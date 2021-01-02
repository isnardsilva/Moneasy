//
//  BalanceViewController.swift
//  Moneasy
//
//  Created by Isnard Silva on 02/01/21.
//

import UIKit

final class BalanceViewController: UIViewController {
    // MARK: - Properties
    weak var coordinator: MainCoordinator?
    
    
    // MARK: - View Life Cycle
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarButtons()
    }
}


// MARK: - Navigation Bar
extension BalanceViewController {
    private func setupNavigationBarButtons() {
        let signOutBarButtom = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(signOut))
        navigationItem.rightBarButtonItem = signOutBarButtom
    }
}


// MARK: - Actions
extension BalanceViewController {
    @objc private func signOut() {
        AuthManager().deleteUserSession(completionHandler: { [weak self] error in
            if error != nil {
                let title = "Falha ao tentar sair"
                let message = "Ocorreu um error no logout. Tente novamente"
                let alert = AlertManager().createDefaultAlert(title: title, message: message)
                self?.present(alert, animated: true, completion: nil)
            } else {
                self?.coordinator?.navigateToLogin()
            }
        })
    }
}
