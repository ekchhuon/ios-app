//
//  KeychainStore.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import Foundation
import KeychainSwift

protocol SecureStorageProtocol {
    func save(_ value: String, forKey key: String) -> Bool
    func load(forKey key: String) -> String?
    func remove(forKey key: String) -> Bool
    func clearAll() -> Bool
}

class KeychainStore: SecureStorageProtocol {
    static let shared = KeychainStore()
    private let keychain: KeychainSwift
    
    private init() {
        self.keychain = KeychainSwift()
        keychain.accessGroup = nil // Set if using app groups
    }
    
    func save(_ value: String, forKey key: String) -> Bool {
        return keychain.set(value, forKey: key)
    }
    
    func load(forKey key: String) -> String? {
        return keychain.get(key)
    }
    
    func remove(forKey key: String) -> Bool {
        return keychain.delete(key)
    }
    
    func clearAll() -> Bool {
        return keychain.clear()
    }
}

