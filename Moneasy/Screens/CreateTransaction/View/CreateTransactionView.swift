//
//  CreateTransactionView.swift
//  Moneasy
//
//  Created by Isnard Silva on 03/01/21.
//

import UIKit

final class CreateTransactionView: UIView {
    // MARK: - Views
    // Inputs
    private let inputsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Nome"
        return textField
    }()
    
    let valueTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Valor"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Descrição"
        return textField
    }()
    
    // Buttons
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Salvar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
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


// MARK: - View Codable
extension CreateTransactionView: ViewCodable {
    func setupHierarchy() {
        addSubview(inputsStackView)
        inputsStackView.addArrangedSubview(nameTextField)
        inputsStackView.addArrangedSubview(valueTextField)
        inputsStackView.addArrangedSubview(descriptionTextField)
        
        addSubview(saveButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            inputsStackView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 30),
            inputsStackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            inputsStackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: inputsStackView.bottomAnchor, constant: 16),
            saveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .systemBackground
    }
}
