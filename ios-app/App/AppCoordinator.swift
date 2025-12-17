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
    var parentCoordinator: Coordinator? { get set }
    
    func start()
    func finish()
}

extension Coordinator {
    func addChildCoordinator(_ coordinator: Coordinator) {
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    // Default implementation of finish
    func finish() {
        // Clean up all child coordinators
        childCoordinators.forEach { $0.finish() }
        childCoordinators.removeAll()
        
        // Remove self from parent
        parentCoordinator?.removeChildCoordinator(self)
    }
}

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator? = nil
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        // Check if user is authenticated or needs onboarding
        if shouldShowOnboarding() {
            showOnboarding()
        } else {
            showHome()
        }
    }
    
    func finish() {
        // App coordinator doesn't finish - it's the root
        // But we can clean up children if needed
        childCoordinators.forEach { $0.finish() }
        childCoordinators.removeAll()
    }
    
    private func shouldShowOnboarding() -> Bool {
        // Check user defaults or keychain for onboarding status
        return !UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    }
    
    private func showOnboarding() {
        let onboardingCoordinator = OnboardingCoordinator(navigationController: navigationController)
        addChildCoordinator(onboardingCoordinator)
        onboardingCoordinator.start()
    }
    
    func showHome() {
        // Remove any existing coordinators
        removeAllChildCoordinators()
        
        let coordinator = HomeCoordinator(navigationController: navigationController)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}

