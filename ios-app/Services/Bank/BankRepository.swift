//
//  BankRepository.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import Foundation

protocol BankRepositoryProtocol {
    func getAccountBalance() async throws -> Double
    func transferMoney(amount: Double, toAccount: String) async throws -> Bool
}

class BankRepository: BankRepositoryProtocol {
    private let service: BankServiceProtocol
    private let storage: StorageProtocol
    
    init(service: BankServiceProtocol, storage: StorageProtocol = UserDefaultsStore.shared) {
        self.service = service
        self.storage = storage
    }
    
    func getAccountBalance() async throws -> Double {
        return try await withCheckedThrowingContinuation { continuation in
            service.getAccountBalance { result in
                switch result {
                case .success(let balance):
                    continuation.resume(returning: balance)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func transferMoney(amount: Double, toAccount: String) async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            service.transferMoney(amount: amount, toAccount: toAccount) { result in
                switch result {
                case .success(let success):
                    continuation.resume(returning: success)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

