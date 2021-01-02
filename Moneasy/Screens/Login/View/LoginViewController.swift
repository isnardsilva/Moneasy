//
//  LoginViewController.swift
//  Moneasy
//
//  Created by Isnard Silva on 02/01/21.
//

import UIKit

final class LoginViewController: UIViewController {
    // MARK: - Properties
    private lazy var baseView = LoginView()
    private let viewModel = LoginViewModel()
    
    weak var coordinator: MainCoordinator?
    
    
    // MARK: - View Life Cycle
    override func loadView() {
        super.loadView()
        self.view = baseView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActions()
    }
}


// MARK: - Actions
extension LoginViewController {
    private func setupActions() {
        baseView.signInButton.addTarget(self, action: #selector(signInButtonTouched(_:)), for: .touchUpInside)
        baseView.signUpButton.addTarget(self, action: #selector(signUpButtonTouched(_:)), for: .touchUpInside)
    }
    
    @objc private func signInButtonTouched(_ sender: UIButton) {
        print("Entrar")
    }
    
    @objc private func signUpButtonTouched(_ sender: UIButton) {
        print("Cadastrar-se")
    }
}
