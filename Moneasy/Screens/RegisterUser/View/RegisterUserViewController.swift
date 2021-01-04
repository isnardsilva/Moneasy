//
//  RegisterUserViewController.swift
//  Moneasy
//
//  Created by Isnard Silva on 04/01/21.
//

import UIKit

final class RegisterUserViewController: UIViewController {
    // MARK: - Properties
    weak var coordinator: MainCoordinator?
    private lazy var baseView = RegisterUserView()
    private lazy var viewModel: RegisterUserViewModel = {
        let viewModel = RegisterUserViewModel()
        
        viewModel.didRegisterUserSuccess = { [weak self] in
            self?.didRegisterUserSuccess()
        }
        
        viewModel.didRegisterUserError = { [weak self] error in
            self?.didRegisterUserError(error: error)
        }
        
        return viewModel
    }()
    
    
    // MARK: - View Life Cycle
    override func loadView() {
        super.loadView()
        self.view = baseView
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
extension RegisterUserViewController {
    private func setupNavigationBarButtons() {
        let saveBarButtonItem = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(createUser))
        navigationItem.rightBarButtonItem = saveBarButtonItem
    }
}

// MARK: - Actions
extension RegisterUserViewController {
    @objc private func createUser() {
        enableLoadingMode(true)
        
        guard let typedEmail = baseView.emailTextField.text, !typedEmail.isEmpty else {
            showDefaultAlert(title: "Opa", message: "Insira um e-mail")
            enableLoadingMode(false)
            return
        }
        
        guard let typedPassword = baseView.passwordTextField.text, !typedPassword.isEmpty else {
            showDefaultAlert(title: "Opa", message: "Insira uma senha")
            enableLoadingMode(false)
            return
        }
        
        if typedPassword.count < 6 {
            showDefaultAlert(title: "Opa", message: "A senha deve ter mais que 6 caracteres.")
            enableLoadingMode(false)
            return
        }
        
        
        viewModel.createUser(email: typedEmail, password: typedPassword)
    }
}

// MARK: - Handle Loading Mode
extension RegisterUserViewController {
    private func enableLoadingMode(_ enable: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = !enable
        baseView.enableLoadingMode(enable)
    }
}


// MARK: - Handle Alerts
extension RegisterUserViewController {
    private func showDefaultAlert(title: String, message: String) {
        let alert = AlertManager().createDefaultAlert(title: title, message: message)
        self.present(alert, animated: true, completion: nil)
    }
}


// MARK: - Handle View Model Responses
extension RegisterUserViewController {
    private func didRegisterUserSuccess() {
        coordinator?.navigateToBalance()
    }
    
    private func didRegisterUserError(error: Error) {
        enableLoadingMode(false)
        
        let title = "Opa"
        let message = error.localizedDescription
        self.showDefaultAlert(title: title, message: message)
    }
}
