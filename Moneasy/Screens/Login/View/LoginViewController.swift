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
    private lazy var viewModel: LoginViewModel = {
        let viewModel = LoginViewModel()
        
        viewModel.didLoginSuccess = { [weak self] in
            self?.didLoginSuccess()
        }
        
        viewModel.didLoginError = { [weak self] error in
            self?.didLoginError(error: error)
        }
        
        return viewModel
    }()
    
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
        baseView.signInWithEmailButton.addTarget(self, action: #selector(signInWithEmailButtonTouched(_:)), for: .touchUpInside)
        baseView.signUpButton.addTarget(self, action: #selector(signUpButtonTouched(_:)), for: .touchUpInside)
    }
    
    @objc private func signInWithEmailButtonTouched(_ sender: UIButton) {
        baseView.enableLoadingMode(true)
        
        guard let typedEmail = baseView.emailTextField.text else {
            print("Error ao tentar pegar o e-mail")
            return
        }
        
        guard let typedPassword = baseView.passwordTextField.text else {
            print("Error ao tentar pegar a senha")
            return
        }
        
        let loginWithEmail = LoginWithEmail(email: typedEmail, password: typedPassword)
        viewModel.authenticate(loginMethod: loginWithEmail)
    }
    
    @objc private func signUpButtonTouched(_ sender: UIButton) {
        coordinator?.navigateToRegisterUser()
    }
}


// MARK: - Handle Login Errors and Successes
extension LoginViewController {
    private func didLoginSuccess() {
        coordinator?.navigateToBalance()
    }
    
    private func didLoginError(error: Error) {
        baseView.enableLoadingMode(false)
        
        let title = "Opa"
        let message = error.localizedDescription
        
        let alert = AlertManager().createDefaultAlert(title: title, message: message)
        self.present(alert, animated: true, completion: nil)
    }
}
