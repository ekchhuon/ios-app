//
//  ProfileCoordinator.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import UIKit

class ProfileCoordinator: BaseCoordinator {
    override func start() {
        let viewModel = ProfileViewModel()
        let viewController = ProfileViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

