//
//  ProfileViewModel.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import Foundation
import Combine

class ProfileViewModel: BaseViewModel {
    @Published var userName: String = "User"
    @Published var userEmail: String = "user@example.com"
    
    override init() {
        super.init()
        loadProfile()
    }
    
    private func loadProfile() {
        // Load user profile data
        // This would typically fetch from API or storage
    }
}

