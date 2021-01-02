//
//  MainCoordinator.swift
//  Moneasy
//
//  Created by Isnard Silva on 02/01/21.
//

import UIKit

final class MainCoordinator: Coordinator {
    // MARK: - Properties
    var navigationController: UINavigationController
    
    
    // MARK: - Initialization
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    // MARK: - Start Method
    func start() {
        navigateToLogin()
    }
}


// MARK: - Navigation
extension MainCoordinator {
    func navigateToLogin() {
        let loginVC = LoginViewController()
        loginVC.coordinator = self
        
        // Set new root view controller
        if navigationController.viewControllers.isEmpty {
            navigationController.pushViewController(loginVC, animated: true)
        } else {
            navigationController.viewControllers.insert(loginVC, at: 0)
            navigationController.popToRootViewController(animated: false)
        }
    }
}
