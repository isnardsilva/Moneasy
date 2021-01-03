//
//  TransactionListViewModel.swift
//  Moneasy
//
//  Created by Isnard Silva on 03/01/21.
//

import Foundation

class TransactionListViewModel {
    // MARK: - Properties
    private let transactionService = TransactionService()
    private(set) var transactions: [Transaction]
    
    var didReceiveTransactions: (() -> Void)?
    var didReceiveError: ((Error) -> Void)?
    
    
    // MARK: - Initialization
    init(transactions: [Transaction] = []) {
        self.transactions = transactions
    }
}


// MARK: - Fetch Methods
extension TransactionListViewModel {
    func fetchTransactions() {
        transactionService.fetchTransactions(completionHandler: { [weak self] result in
            switch result {
            case .failure(let error):
                self?.didReceiveError?(error)
                
            case .success(let receivedTransactions):
                self?.transactions = receivedTransactions
                self?.didReceiveTransactions?()
            }
        })
    }
}
