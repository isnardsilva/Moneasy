//
//  TransactionViewModel.swift
//  Moneasy
//
//  Created by Isnard Silva on 04/01/21.
//

import Foundation

class TransactionViewModel {
    // MARK: - Properties
    private let transaction: Transaction
    
    var name: String {
        return transaction.name
    }
    
    var userUid: String {
        return transaction.userUid
    }
    
    var value: Double {
        return transaction.value
    }
    
    var formattedValue: String {
        let sign = transaction.type == .expense ? "-" : ""
        return String(format: "R$ \(sign)%.02f", transaction.value)
    }
    
    var description: String {
        return transaction.description
    }
    
    var date: Date {
        return transaction.date
    }
    
    var formattedDate: String {
        return transaction.date.toString(withFormat: "dd/MM/yyyy")
    }
    
    var type: TransactionType {
        return transaction.type
    }
    
    var status: Bool {
        return transaction.status
    }
    
    
    // MARK: - Initialization
    init(transaction: Transaction) {
        self.transaction = transaction
    }
}
