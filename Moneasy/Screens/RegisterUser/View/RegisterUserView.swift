//
//  RegisterUserView.swift
//  Moneasy
//
//  Created by Isnard Silva on 04/01/21.
//

import UIKit

final class RegisterUserView: UIView {
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
        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Senha"
        textField.autocapitalizationType = .none
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        return textField
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

// MARK: - Handle loading mode
extension RegisterUserView {
    func enableLoadingMode(_ enable: Bool) {
        emailTextField.isEnabled = !enable
        passwordTextField.isEnabled = !enable
    }
}


// MARK: - View Codable
extension RegisterUserView: ViewCodable {
    func setupHierarchy() {
        addSubview(contentStackView)
        
        // Inputs
        contentStackView.addArrangedSubview(inputsStackView)
        inputsStackView.addArrangedSubview(emailTextField)
        inputsStackView.addArrangedSubview(passwordTextField)
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

