//
//  TransactionDetailView.swift
//  Moneasy
//
//  Created by Isnard Silva on 03/01/21.
//

import UIKit

final class TransactionDetailView: UIView {
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
extension TransactionDetailView: ViewCodable {
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
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            inputsStackView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 30),
            inputsStackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            inputsStackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .systemBackground
    }
}
