//
//  CreateTransactionViewController.swift
//  Moneasy
//
//  Created by Isnard Silva on 03/01/21.
//

import UIKit

final class CreateTransactionViewController: UIViewController {
    // MARK: - Properties
    weak var coordinator: MainCoordinator?
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add", for: .normal)
        return button
    }()
    
    
    // MARK: - View Life Cycle
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.addTarget(self, action: #selector(saveTransaction), for: .touchUpInside)
    }
    
    @objc private func saveTransaction() {
        print("Save")
    }
}
