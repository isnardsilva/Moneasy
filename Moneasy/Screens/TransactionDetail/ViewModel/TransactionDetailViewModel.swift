//
//  TransactionDetailViewModel.swift
//  Moneasy
//
//  Created by Isnard Silva on 04/01/21.
//

import Foundation

final class TransactionDetailViewModel {
    private let transactionService = TransactionService()
    
    // MARK: - Service Methods
    func saveTransaction(_ transaction: Transaction, completionHandler: @escaping (Error?) -> Void) {
        transactionService.addTransaction(transaction, completionHandler: { error in
            completionHandler(error)
        })
    }
    
    func updateTransaction(_ transaction: Transaction, completionHandler: @escaping (Error?) -> Void) {
        transactionService.updateTransaction(transaction, completionHandler: { error in
            completionHandler(error)
        })
    }
    
    func deleteTransaction(_ transaction: Transaction, completionHandler: @escaping (Error?) -> Void) {
        transactionService.deleteTransaction(transaction, completionHandler: { error in
            completionHandler(error)
        })
    }
}
