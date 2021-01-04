//
//  TransactionDetailViewController.swift
//  Moneasy
//
//  Created by Isnard Silva on 03/01/21.
//

import UIKit

final class TransactionDetailViewController: UIViewController {
    // MARK: - Properties
    private lazy var baseView = TransactionDetailView()
    private let viewModel = TransactionDetailViewModel()
    weak var coordinator: MainCoordinator?

    var existingTransaction: Transaction?
    
    
    // MARK: - Initialization
    init(transaction: Transaction? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.existingTransaction = transaction
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Life Cycle
    override func loadView() {
        super.loadView()
        self.view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if is update mode
        if let validTransaction = existingTransaction {
            setExistingData(transaction: validTransaction)
        }
        
        setupNavigationBarButtons()
        setupActions()
    }
}

// MARK: - Navigation Bar
extension TransactionDetailViewController {
    private func setupNavigationBarButtons() {
        let saveBarButtomItem = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(saveTransaction))
        navigationItem.rightBarButtonItem = saveBarButtomItem
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
}


// MARK: - Actions
extension TransactionDetailViewController {
    private func setupActions() {
        baseView.transactionTypeSegmentControl.addTarget(self, action: #selector(handleSelectionTransactionType(_:)), for: .allEvents)
    }
    
    @objc private func saveTransaction() {
        
        // Check if is updating or saving
        if existingTransaction != nil {
            // Update
            self.handleUpdatingTransaction()
        } else {
            // Save
            self.handleSavingTransaction()
        }
    }
    
    @objc private func handleSelectionTransactionType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            baseView.statusLabel.text = "Recebido"
        case 1:
            baseView.statusLabel.text = "Pago"
        default:
            break
        }
    }
}

// MARK: - Handle Saving Calls
extension TransactionDetailViewController {
    private func handleSavingTransaction() {
        guard let dataEntered = self.getDataEntered() else {
            return
        }
        
        AuthManager().getUserUid(completionHandler: { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                
            case .success(let userUid):
                
                let transaction = Transaction(name: dataEntered.name,
                                              userUid: userUid,
                                              value: dataEntered.value,
                                              description: dataEntered.description,
                                              date: dataEntered.date,
                                              type: dataEntered.transactionType,
                                              status: dataEntered.status)
                
                self?.viewModel.saveTransaction(transaction, completionHandler: { error in
                    if let detectedError = error {
                        self?.showAlert(title: "Atenção", message: detectedError.localizedDescription)
                    } else {
                        print("Save success")
                        self?.coordinator?.closeCurrentScreen()
                    }
                })
            }
        })
    }
    
    private func handleUpdatingTransaction() {
        guard let validTransaction = self.existingTransaction,
              let dataEntered = self.getDataEntered() else {
            return
        }
        
        let updatedTransaction = Transaction(name: dataEntered.name,
                                             userUid: validTransaction.userUid,
                                             value: dataEntered.value,
                                             description: dataEntered.description,
                                             date: dataEntered.date,
                                             type: dataEntered.transactionType,
                                             status: dataEntered.status)
        
        viewModel.updateTransaction(updatedTransaction, completionHandler: { [weak self] error in
            if let detectedError = error {
                self?.showAlert(title: "Atenção", message: detectedError.localizedDescription)
            } else {
                print("Update success")
                self?.coordinator?.closeCurrentScreen()
            }
        })
    }
}


// MARK: - Handle Transaction Data
extension TransactionDetailViewController {
    // swiftlint:disable large_tuple
    private func getDataEntered() -> (name: String, value: Double, description: String, date: Date, transactionType: TransactionType, status: Bool)? {
        guard let typedName = baseView.nameTextField.text, !typedName.isEmpty else {
            self.showAlert(title: "Atenção", message: "Insira um nome")
            return nil
        }
        
        guard let strValue = baseView.valueTextField.text, !strValue.isEmpty else {
//            print("Insira o valor")
            self.showAlert(title: "Atenção", message: "Insira o valor")
            return nil
        }
        
        guard let typedValue = Double(strValue) else {
//            print("Insira um valor válido")
            self.showAlert(title: "Atenção", message: "Insira um valor válido")
            return nil
        }
        
        let typedDescription = baseView.descriptionTextField.text ?? ""
        let typedDate = baseView.datePicker.date
        
        let selectedTransactionTypeIndex = baseView.transactionTypeSegmentControl.selectedSegmentIndex
        let selectedTransactionType: TransactionType = selectedTransactionTypeIndex == 0 ? .revenue : .expense
        
        return (name: typedName, value: typedValue, description: typedDescription, date: typedDate, transactionType: selectedTransactionType, status: baseView.statusSwitch.isOn)
    }
    
    private func setExistingData(transaction: Transaction) {
        baseView.nameTextField.text = transaction.name
        baseView.valueTextField.text = transaction.value.description
        baseView.descriptionTextField.text = transaction.description
        baseView.datePicker.setDate(transaction.date, animated: true)
        
        switch transaction.type {
        case .expense:
            baseView.transactionTypeSegmentControl.selectedSegmentIndex = 1
            baseView.statusLabel.text = "Pago"
        case .revenue:
            baseView.transactionTypeSegmentControl.selectedSegmentIndex = 0
            baseView.statusLabel.text = "Recebido"
        }
        
        baseView.statusSwitch.isOn = transaction.status
    }
}


// MARK: - Handle Alerts
extension TransactionDetailViewController {
    private func showAlert(title: String, message: String) {
        let alert = AlertManager().createDefaultAlert(title: title, message: message)
        self.present(alert, animated: true, completion: nil)
    }
}
