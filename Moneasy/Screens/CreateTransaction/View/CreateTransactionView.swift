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
        stackView.spacing = 16
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
    
    private let dateFieldComponentsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Data"
        return label
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    let transactionTypeSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Receita", "Despesa"])
        segmentControl.selectedSegmentIndex = 0
        
        return segmentControl
    }()
    
    
    private let statusComponentsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Recebido"
        return label
    }()
    
    let statusSwitch: UISwitch = {
        let statusSwitch = UISwitch()
        statusSwitch.isOn = true
        return statusSwitch
    }()
    
    
    // Buttons
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Salvar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    /*
     let name: String
     let userUid: String
     let value: Double
     let description: String
     let date: Date
     let type: TransactionType
     let status: Bool // Despesa (está pago?) / Receita (recebido?)
     */
    
    
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
        
        inputsStackView.addArrangedSubview(dateFieldComponentsStackView)
        dateFieldComponentsStackView.addArrangedSubview(dateLabel)
        dateFieldComponentsStackView.addArrangedSubview(datePicker)
        
        inputsStackView.addArrangedSubview(transactionTypeSegmentControl)
        
        inputsStackView.addArrangedSubview(statusComponentsStackView)
        statusComponentsStackView.addArrangedSubview(statusLabel)
        statusComponentsStackView.addArrangedSubview(statusSwitch)
        
        addSubview(saveButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            inputsStackView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 30),
            inputsStackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            inputsStackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: inputsStackView.bottomAnchor, constant: 50),
            saveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .systemBackground
    }
}
