//
//  ReachabilityManager.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import Foundation
import Network

protocol ReachabilityManagerProtocol {
    var isConnected: Bool { get }
    func startMonitoring()
    func stopMonitoring()
    func observeConnectionChanges(_ observer: @escaping (Bool) -> Void)
}

class ReachabilityManager: ReachabilityManagerProtocol {
    static let shared = ReachabilityManager()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "ReachabilityManager")
    private var observers: [(Bool) -> Void] = []
    
    private(set) var isConnected: Bool = true
    
    private init() {
        startMonitoring()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            let isConnected = path.status == .satisfied
            self?.isConnected = isConnected
            
            DispatchQueue.main.async {
                self?.observers.forEach { $0(isConnected) }
            }
            
            Logger.shared.info("Network status changed: \(isConnected ? "Connected" : "Disconnected")")
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
    func observeConnectionChanges(_ observer: @escaping (Bool) -> Void) {
        observers.append(observer)
        // Immediately notify with current status
        observer(isConnected)
    }
}

