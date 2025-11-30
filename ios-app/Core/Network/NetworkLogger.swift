//
//  NetworkLogger.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import Foundation

class NetworkLogger {
    
    private let isEnabled: Bool
    
    init(isEnabled: Bool = true) {
        #if DEBUG
        self.isEnabled = isEnabled
        #else
        self.isEnabled = false
        #endif
    }
    
    func log(request: URLRequest) {
        guard isEnabled else { return }
        
        Logger.shared.debug("🌐 ===== Network Request =====")
        Logger.shared.debug("URL: \(request.url?.absoluteString ?? "Unknown")")
        Logger.shared.debug("Method: \(request.httpMethod ?? "Unknown")")
        
        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            Logger.shared.debug("Headers: \(headers)")
        }
        
        if let body = request.httpBody,
           let jsonString = String(data: body, encoding: .utf8) {
            Logger.shared.debug("Body: \(jsonString)")
        }
        
        Logger.shared.debug("=============================")
    }
    
    func log(response: URLResponse, data: Data) {
        guard isEnabled else { return }
        
        Logger.shared.debug("📡 ===== Network Response =====")
        
        if let httpResponse = response as? HTTPURLResponse {
            Logger.shared.debug("Status Code: \(httpResponse.statusCode)")
            Logger.shared.debug("URL: \(httpResponse.url?.absoluteString ?? "Unknown")")
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            Logger.shared.debug("Response: \(jsonString)")
        } else {
            Logger.shared.debug("Response: \(data.count) bytes")
        }
        
        Logger.shared.debug("==============================")
    }
    
    func log(error: Error) {
        guard isEnabled else { return }
        
        Logger.shared.error("❌ ===== Network Error =====")
        Logger.shared.error("Error: \(error.localizedDescription)")
        Logger.shared.error("============================")
    }
}

