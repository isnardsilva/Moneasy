//
//  TransactionDetailViewModel.swift
//  Moneasy
//
//  Created by Isnard Silva on 04/01/21.
//

import Foundation

final class TransactionDetailViewModel {
    
    // MARK: - Service Methods
    func saveTransaction(_ transaction: Transaction, completionHandler: @escaping (Error?) -> Void) {
        TransactionService().addTransaction(transaction, completionHandler: { error in
            completionHandler(error)
        })
    }
    
    func updateTransaction(_ transaction: Transaction, completionHandler: @escaping (Error?) -> Void) {
        
    }
    
    func deleteTransaction(_ transaction: Transaction, completionHandler: @escaping (Error?) -> Void) {
        
    }
}
