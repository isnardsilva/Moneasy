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
                                              status: true)
                
                TransactionService().addTransaction(transaction, completionHandler: { error in
                    if let detectedError = error {
                        print(detectedError.localizedDescription)
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
    private func getDataEntered() -> (name: String, value: Double, description: String, date: Date, transactionType: TransactionType)? {
        guard let typedName = baseView.nameTextField.text, !typedName.isEmpty else {
            print("Insira um nome")
            return nil
        }
        
        guard let strValue = baseView.valueTextField.text, !strValue.isEmpty else {
            print("Insira o valor")
            return nil
        }
        
        guard let typedValue = Double(strValue) else {
            print("Insira um valor válido")
            return nil
        }
        
        let typedDescription = baseView.descriptionTextField.text ?? ""
        let typedDate = Date()
        
        return (name: typedName, value: typedValue, description: typedDescription, date: typedDate, transactionType: TransactionType.expense)
    }
}
