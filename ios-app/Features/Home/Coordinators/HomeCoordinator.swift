//
//  HomeCoordinator.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import UIKit

class HomeCoordinator: BaseCoordinator {
    override func start() {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        
        // Set coordinator BEFORE adding to navigation stack
        viewController.coordinator = self
        
        navigationController.setViewControllers([viewController], animated: false)
        
        // Verify and set coordinator again after adding to stack (safety check)
        if let topVC = navigationController.topViewController as? HomeViewController {
            topVC.coordinator = self
        }
    }
    
    func showProfile() {
        let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
        profileCoordinator.parentCoordinator = self
        addChildCoordinator(profileCoordinator)
        profileCoordinator.start()
    }
    
    func showSettings() {
        let settingsCoordinator = SettingsCoordinator(navigationController: navigationController)
        settingsCoordinator.parentCoordinator = self
        addChildCoordinator(settingsCoordinator)
        settingsCoordinator.start()
    }
}

