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
    
    private(set) var transactions: [Transaction] {
        didSet {
            updateBalanceValue()
        }
    }
    private(set) var balanceValue: Double = 0
    private(set) var revenueValue: Double = 0
    private(set) var expenseValue: Double = 0
    
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
        transactionService.fetchTransactionsOrderByDate(completionHandler: { [weak self] result in
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


// MARK: - Handle Balance Value
extension TransactionListViewModel {
    private func updateBalanceValue() {
        var newExpenseValue = 0.0
        var newRevenueValue = 0.0
        
        for transaction in transactions {
            switch transaction.type {
            case .expense:
                newExpenseValue += transaction.value
            case .revenue:
                newRevenueValue += transaction.value
            }
        }
        
        self.revenueValue = newRevenueValue
        self.expenseValue = newExpenseValue
        self.balanceValue = newRevenueValue - newExpenseValue
    }
}
