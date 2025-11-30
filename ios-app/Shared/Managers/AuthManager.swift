//
//  AuthManager.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import Foundation

protocol AuthManagerProtocol {
    var isAuthenticated: Bool { get }
    func saveAccessToken(_ token: String)
    func getAccessToken() -> String?
    func saveRefreshToken(_ token: String)
    func getRefreshToken() -> String?
    func logout()
}

class AuthManager: AuthManagerProtocol {
    static let shared = AuthManager()
    
    private let keychainStore: SecureStorageProtocol
    private let userDefaultsStore: StorageProtocol
    
    private let accessTokenKey = "access_token"
    private let refreshTokenKey = "refresh_token"
    private let isAuthenticatedKey = "is_authenticated"
    
    var isAuthenticated: Bool {
        return UserDefaults.standard.bool(forKey: isAuthenticatedKey) && getAccessToken() != nil
    }
    
    private init() {
        self.keychainStore = KeychainStore.shared
        self.userDefaultsStore = UserDefaultsStore.shared
    }
    
    func saveAccessToken(_ token: String) {
        keychainStore.save(token, forKey: accessTokenKey)
        UserDefaults.standard.set(true, forKey: isAuthenticatedKey)
    }
    
    func getAccessToken() -> String? {
        return keychainStore.load(forKey: accessTokenKey)
    }
    
    func saveRefreshToken(_ token: String) {
        keychainStore.save(token, forKey: refreshTokenKey)
    }
    
    func getRefreshToken() -> String? {
        return keychainStore.load(forKey: refreshTokenKey)
    }
    
    func logout() {
        keychainStore.remove(forKey: accessTokenKey)
        keychainStore.remove(forKey: refreshTokenKey)
        UserDefaults.standard.set(false, forKey: isAuthenticatedKey)
        Logger.shared.info("User logged out")
    }
}

