//
//  BaseViewModel.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import Foundation
import Combine

/// Base ViewModel class for all ViewModels.
/// Note: Subclasses that use @Published or other Combine features directly
/// must also import Combine in their own files, as Swift requires each file
/// to import modules it directly uses.
class BaseViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    deinit {
        cancellables.removeAll()
    }
    
    func handleError(_ error: Error) {
        errorMessage = error.localizedDescription
        Logger.shared.error("Error: \(error.localizedDescription)")
    }
}

