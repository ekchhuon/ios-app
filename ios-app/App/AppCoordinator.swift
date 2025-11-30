//
//  AppCoordinator.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

extension Coordinator {
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var window: UIWindow
    private var homeCoordinator: HomeCoordinator? // Retain reference
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        // Check if user is authenticated or needs onboarding
//        if shouldShowOnboarding() {
//            showOnboarding()
//        } else {
//            showHome()
//        }
        
        showHome()
    }
    
    private func shouldShowOnboarding() -> Bool {
        // Check user defaults or keychain for onboarding status
        return !UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    }
    
    private func showOnboarding() {
        let onboardingCoordinator = OnboardingCoordinator(navigationController: navigationController)
        onboardingCoordinator.parentCoordinator = self
        addChildCoordinator(onboardingCoordinator)
        onboardingCoordinator.start()
    }
    
    private func showHome() {
        let coordinator = HomeCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        addChildCoordinator(coordinator)
        self.homeCoordinator = coordinator // Retain reference
        coordinator.start()
    }
}

