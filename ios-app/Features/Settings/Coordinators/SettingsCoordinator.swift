//
//  SettingsCoordinator.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import UIKit

class SettingsCoordinator: BaseCoordinator {
    override func start() {
        let viewModel = SettingsViewModel()
        let viewController = SettingsViewController(viewModel: viewModel)
        viewController.coordinator = self
        viewController.onDismiss = { [weak self] in
            self?.parentCoordinator?.childDidFinish(self)
        }
        navigationController.pushViewController(viewController, animated: true)
    }
}

