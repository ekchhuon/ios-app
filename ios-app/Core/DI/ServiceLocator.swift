//
//  ServiceLocator.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import Foundation

protocol ServiceLocating {
    func getService<T>() -> T?
    func register<T>(_ service: T)
}

final class ServiceLocator: ServiceLocating {
    static let shared = ServiceLocator()
    
    private var services: [String: Any] = [:]
    
    private init() {}
    
    func register<T>(_ service: T) {
        let key = String(describing: T.self)
        services[key] = service
    }
    
    func getService<T>() -> T? {
        let key = String(describing: T.self)
        return services[key] as? T
    }
}

// MARK: - Service Registration
extension ServiceLocator {
    func registerServices() {
        // Register Network Services
        register(APIClient.shared as APIClientProtocol)
        register(ReachabilityManager.shared as ReachabilityManagerProtocol)
        
        // Register Storage Services
        register(UserDefaultsStore.shared as StorageProtocol)
        register(KeychainStore.shared as SecureStorageProtocol)
        
        // Register Managers
        register(AuthManager.shared as AuthManagerProtocol)
    }
}

