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
        // Navigate to home or login
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.parentCoordinator = parentCoordinator
        parentCoordinator?.addChildCoordinator(homeCoordinator)
        parentCoordinator?.removeChildCoordinator(self)
        homeCoordinator.start()
    }
}

