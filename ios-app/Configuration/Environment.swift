//
//  Environment.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import Foundation

enum Environment {
    case development
    case staging
    case production
    
    static var current: Environment {
        #if DEBUG
        return .development
        #elseif STAGING
        return .staging
        #else
        return .production
        #endif
    }
    
    var baseURL: String {
        switch self {
        case .development:
            return "https://api-dev.example.com"
        case .staging:
            return "https://api-staging.example.com"
        case .production:
            return "https://api.example.com"
        }
    }
    
    var apiKey: String {
        switch self {
        case .development:
            return "dev-api-key"
        case .staging:
            return "staging-api-key"
        case .production:
            return "prod-api-key"
        }
    }
}

