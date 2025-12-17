//
//  OnboardingCoordinator.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import UIKit

class OnboardingCoordinator: BaseCoordinator {
    override func start() {
        let viewModel = OnboardingViewModel()
        let viewController = OnboardingViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        
        // Notify parent coordinator to show home
        if let appCoordinator = parentCoordinator as? AppCoordinator {
            finish() // Clean up onboarding coordinator
            appCoordinator.showHome()
        }
    }
}

