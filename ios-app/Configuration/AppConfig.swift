//
//  AppConfig.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import Foundation

struct AppConfig {
    static let appName = "iOS App"
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    static let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    
    // API Configuration
    static var baseURL: String {
        return Environment.current.baseURL
    }
    
    // App Settings
    static let defaultTimeout: TimeInterval = 30.0
    static let maxRetryAttempts = 3
}

