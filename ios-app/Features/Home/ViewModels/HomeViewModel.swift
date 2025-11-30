//
//  HomeViewModel.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import Foundation
import Combine

class HomeViewModel: BaseViewModel {
    @Published var welcomeMessage: String = "Welcome!"
    
    override init() {
        super.init()
        loadData()
    }
    
    private func loadData() {
        isLoading = true
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.welcomeMessage = "Welcome to iOS App!"
            self?.isLoading = false
        }
    }
}

