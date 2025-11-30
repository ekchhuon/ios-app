//
//  Constants.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import Foundation
import UIKit

struct Constants {
    
    // MARK: - API Configuration
    struct API {
        #if DEBUG
        static let baseURL = "https://api-dev.example.com"
        #elseif STAGING
        static let baseURL = "https://api-staging.example.com"
        #else
        static let baseURL = "https://api.example.com"
        #endif
        
        static let timeout: TimeInterval = 30
        static let apiVersion = "/v1"
    }
    
    // MARK: - App Information
    struct App {
        static let name = "iOS App"
        static let bundleIdentifier = Bundle.main.bundleIdentifier ?? ""
        static let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        static let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        
        static var fullVersion: String {
            return "\(version) (\(build))"
        }
    }
    
    // MARK: - URLs
    struct URLs {
        static let termsOfService = "https://example.com/terms"
        static let privacyPolicy = "https://example.com/privacy"
        static let support = "https://support.example.com"
        static let website = "https://example.com"
    }
    
    // MARK: - Validation
    struct Validation {
        static let minPasswordLength = 8
        static let maxPasswordLength = 128
        static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let phoneRegex = "^[+]?[0-9]{10,15}$"
    }
    
    // MARK: - Animation
    struct Animation {
        static let defaultDuration: TimeInterval = 0.3
        static let longDuration: TimeInterval = 0.5
        static let shortDuration: TimeInterval = 0.2
        static let springDamping: CGFloat = 0.8
        static let springVelocity: CGFloat = 0.5
    }
    
    // MARK: - Layout
    struct Layout {
        static let defaultPadding: CGFloat = 16
        static let smallPadding: CGFloat = 8
        static let largePadding: CGFloat = 24
        static let cornerRadius: CGFloat = 12
        static let smallCornerRadius: CGFloat = 8
        static let buttonHeight: CGFloat = 50
        static let textFieldHeight: CGFloat = 50
    }
    
    // MARK: - Images
    struct Images {
        static let placeholder = "placeholder"
        static let logo = "app_logo"
        static let emptyState = "empty_state"
    }
    
    // MARK: - Keys
    struct Keys {
        static let googleMapsAPIKey = "YOUR_GOOGLE_MAPS_KEY"
        static let firebaseAPIKey = "YOUR_FIREBASE_KEY"
        // Add other API keys here
    }
    
    // MARK: - Feature Flags
    struct FeatureFlags {
        static let isDarkModeEnabled = true
        static let isBiometricAuthEnabled = true
        static let isPushNotificationsEnabled = true
        static let isAnalyticsEnabled = true
    }
    
    // MARK: - Notification Names
    struct Notifications {
        static let userDidLogin = Notification.Name("userDidLogin")
        static let userDidLogout = Notification.Name("userDidLogout")
        static let userProfileUpdated = Notification.Name("userProfileUpdated")
        static let themeDidChange = Notification.Name("themeDidChange")
    }
}

