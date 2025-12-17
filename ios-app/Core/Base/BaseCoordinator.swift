//
//  BaseCoordinator.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import UIKit

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        fatalError("start() method must be implemented")
    }
    
    func finish() {
        // Clean up all child coordinators
        childCoordinators.forEach { $0.finish() }
        childCoordinators.removeAll()
        
        // Remove self from parent
        parentCoordinator?.removeChildCoordinator(self)
    }
    
    // Helper method to clean up when ViewController is popped
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

