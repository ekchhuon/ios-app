//
//  BankService.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import Foundation

protocol BankServiceProtocol {
    func getAccountBalance(completion: @escaping (Result<Double, Error>) -> Void)
    func transferMoney(amount: Double, toAccount: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

class BankService: BankServiceProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient.shared) {
        self.apiClient = apiClient
    }
    
    func getAccountBalance(completion: @escaping (Result<Double, Error>) -> Void) {
        // Implement API call using APIClient
        // This is a placeholder
        completion(.success(1000.0))
    }
    
    func transferMoney(amount: Double, toAccount: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        // Implement API call using APIClient
        // This is a placeholder
        completion(.success(true))
    }
}

