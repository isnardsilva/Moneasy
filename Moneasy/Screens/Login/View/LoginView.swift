//
//  LoginView.swift
//  Moneasy
//
//  Created by Isnard Silva on 02/01/21.
//

import UIKit

final class LoginView: UIView {
    // MARK: - Views
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Inputs
    private let inputsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "E-mail"
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .yes
        textField.keyboardType = .emailAddress
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Senha"
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    
    // Buttons
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Entrar", for: .normal)
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cadastrar-se", for: .normal)
        return button
    }()
    
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: -
extension LoginView: ViewCodable {
    func setupHierarchy() {
        addSubview(contentStackView)
        
        // Inputs
        contentStackView.addArrangedSubview(inputsStackView)
        inputsStackView.addArrangedSubview(emailTextField)
        inputsStackView.addArrangedSubview(passwordTextField)
        
        // Buttons
        contentStackView.addArrangedSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(signInButton)
        buttonsStackView.addArrangedSubview(signUpButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            inputsStackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            inputsStackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .systemBackground
    }
}
