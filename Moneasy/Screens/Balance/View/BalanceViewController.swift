//
//  BalanceViewController.swift
//  Moneasy
//
//  Created by Isnard Silva on 02/01/21.
//

import UIKit

final class BalanceViewController: UIViewController {
    // MARK: - Properties
    weak var coordinator: MainCoordinator?
    
    private lazy var baseView = BalanceView()
    private lazy var viewModel: TransactionListViewModel = {
        let viewModel = TransactionListViewModel()
        
        viewModel.didReceiveTransactions = { [weak self] in
            self?.didReceiveTransactions()
        }
        
        viewModel.didReceiveError = { [weak self] error in
            self?.didReceiveError(error: error)
        }
        
        return viewModel
    }()
    
    
    
    // MARK: - View Life Cycle
    override func loadView() {
        super.loadView()
        self.view = baseView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseView.collectionView.dataSource = self
        baseView.collectionView.delegate = self
        
        setupNavigationBarAppearence()
        setupNavigationBarButtons()
        setupNotificationCenter()
        
        viewModel.fetchTransactions()
    }
}


// MARK: - Navigation Bar
extension BalanceViewController {
    private func setupNavigationBarAppearence() {
        guard let navBar = navigationController?.navigationBar else {
            return
        }
        
        navigationItem.title = "Moneasy"
        
        navBar.barTintColor = UIColor(named: Identifier.Color.balanceHeaderBackground)
//        navBar.tintColor = .system
        navBar.isTranslucent = false
//        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
    }
    
    private func setupNavigationBarButtons() {
        let addTransactionBarButtomItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addNewTransaction))
        navigationItem.rightBarButtonItem = addTransactionBarButtomItem
        
        let signOutBarButtom = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(signOut))
        navigationItem.leftBarButtonItem = signOutBarButtom
    }
}

// MARK: - Actions
extension BalanceViewController {
    @objc private func addNewTransaction() {
        coordinator?.navigateToCreateTransaction()
    }
    
    @objc private func reloadData() {
        viewModel.fetchTransactions()
    }
    
    @objc private func signOut() {
        AuthManager().deleteUserSession(completionHandler: { [weak self] error in
            if error != nil {
                let title = "Falha ao tentar sair"
                let message = "Ocorreu um error no logout. Tente novamente"
                let alert = AlertManager().createDefaultAlert(title: title, message: message)
                self?.present(alert, animated: true, completion: nil)
            } else {
                self?.coordinator?.navigateToLogin()
            }
        })
    }
}


// MARK: - Handle Notification Center
extension BalanceViewController {
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .TransactionServiceUpdated, object: nil)
    }
}


// MARK: - Handle Transactions Updates
extension BalanceViewController {
    private func didReceiveError(error: Error) {
        print("Deu ruim:", error.localizedDescription)
    }
    
    private func didReceiveTransactions() {
        baseView.collectionView.reloadData()
    }
}



// MARK: - UICollectionViewDelegateFlowLayout
extension BalanceViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let leftSectionInsets: CGFloat = 8
        let rightSectionInsets: CGFloat = 8
        
        let paddingSpace = leftSectionInsets + rightSectionInsets
        let availableWidth = collectionView.frame.width - paddingSpace
        
        return CGSize(width: availableWidth, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 270)
    }
}



// MARK: - UICollectionViewDataSource
extension BalanceViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.transactions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // swiftlint:disable line_length
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Identifier.Cell.balanceHeaderView, for: indexPath) as? BalanceHeaderReusableView else {
            fatalError("Error load header view as a BalanceHeaderReusableView")
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.Cell.transactionCell, for: indexPath) as? TransactionCell else {
            fatalError("Error load cell as a TransactionCell")
        }
        
        let transaction = viewModel.transactions[indexPath.row]
        let transactionViewModel = TransactionViewModel(transaction: transaction)
        
        cell.transactionViewModel = transactionViewModel
        
        return cell
    }
}


// MARK: - UICollectionViewDelegate
extension BalanceViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedTransaction = viewModel.transactions[indexPath.row]
        
        print("Selected:", selectedTransaction.name)
    }
}
