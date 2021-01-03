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
        
//        addButton.addTarget(self, action: #selector(saveTransaction), for: .touchUpInside)
    }
    
    @objc private func saveTransaction() {
        print("Save")
    }
}
