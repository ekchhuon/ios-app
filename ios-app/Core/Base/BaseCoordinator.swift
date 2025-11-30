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
        parentCoordinator?.removeChildCoordinator(self)
    }
}

