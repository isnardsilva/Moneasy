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
        // Check if is authenticated
        AuthManager().checkIsAuthenticated(completionHandler: { [weak self] isAuthenticated in
            if isAuthenticated {
                self?.navigateToBalance()
            } else {
                self?.navigateToLogin()
            }
        })
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
    
    func navigateToBalance() {
        let balanceVC = BalanceViewController()
        balanceVC.coordinator = self
        
        // Set new root view controller
        if navigationController.viewControllers.isEmpty {
            navigationController.pushViewController(balanceVC, animated: true)
        } else {
            navigationController.viewControllers.insert(balanceVC, at: 0)
            navigationController.popToRootViewController(animated: false)
        }
    }
    
    func navigateToCreateTransaction() {
        let createTransactionVC = CreateTransactionViewController()
        createTransactionVC.coordinator = self
        navigationController.pushViewController(createTransactionVC, animated: true)
    }
    
    func closeCurrentScreen() {
        navigationController.popViewController(animated: true)
    }
}
