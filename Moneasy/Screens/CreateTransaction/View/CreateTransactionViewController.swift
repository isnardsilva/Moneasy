//
//  CreateTransactionViewController.swift
//  Moneasy
//
//  Created by Isnard Silva on 03/01/21.
//

import UIKit

final class CreateTransactionViewController: UIViewController {
    // MARK: - Properties
    private lazy var baseView = CreateTransactionView()
    weak var coordinator: MainCoordinator?
    
    
    // MARK: - View Life Cycle
    override func loadView() {
        super.loadView()
        self.view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarButtons()
    }
}

// MARK: - Navigation Bar
extension CreateTransactionViewController {
    private func setupNavigationBarButtons() {
        let saveBarButtomItem = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(saveTransaction))
        navigationItem.rightBarButtonItem = saveBarButtomItem
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
}


// MARK: - Actions
extension CreateTransactionViewController {
    @objc private func saveTransaction() {
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
                
                TransactionService().addTransaction(transaction, completionHandler: { error in
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
}


// MARK: - Handle Transaction Data
extension CreateTransactionViewController {
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
}


// MARK: - Handle Alerts
extension CreateTransactionViewController {
    private func showAlert(title: String, message: String) {
        let alert = AlertManager().createDefaultAlert(title: title, message: message)
        self.present(alert, animated: true, completion: nil)
    }
}
