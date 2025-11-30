//
//  SettingsViewModel.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import Foundation
import Combine

class SettingsViewModel: BaseViewModel {
    @Published var settings: [SettingItem] = []
    
    override init() {
        super.init()
        loadSettings()
    }
    
    private func loadSettings() {
        settings = [
            SettingItem(title: "Notifications", type: .toggle, isEnabled: true),
            SettingItem(title: "Dark Mode", type: .toggle, isEnabled: false),
            SettingItem(title: "About", type: .navigation),
            SettingItem(title: "Logout", type: .action)
        ]
    }
    
    func logout() {
        AuthManager.shared.logout()
        // Navigate to login/onboarding
    }
}

struct SettingItem {
    let title: String
    let type: SettingType
    var isEnabled: Bool = false
}

enum SettingType {
    case toggle
    case navigation
    case action
}

