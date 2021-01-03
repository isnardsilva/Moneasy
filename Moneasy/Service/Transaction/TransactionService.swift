//
//  TransactionService.swift
//  Moneasy
//
//  Created by Isnard Silva on 03/01/21.
//

import Firebase

final class TransactionService {
    // MARK: - Properties
    private let database = Firestore.firestore()
    
    
    // MARK: - CRUD Methods
    func addTransaction(_ transaction: Transaction, completionHandler: @escaping (Error?) -> Void) {
        let dictTransaction = self.convertTransactionObjectToDictionary(transaction)
        
        database.collection(Identifier.Database.transactionsKey).addDocument(data: dictTransaction, completion: { error in
            completionHandler(error)
        })
    }
    
    func fetchTransactions(completionHandler: @escaping (Result<[Transaction], Error>) -> Void) {
        
    }
}


// MARK: - Helper Methods
extension TransactionService {
    private func convertTransactionObjectToDictionary(_ transaction: Transaction) -> [String: Any] {
        let dict: [String: Any] = [
            "name": transaction.name,
            "userUid": transaction.userUid,
            "value": transaction.value,
            "description": transaction.description,
            "date": transaction.date,
            "type": transaction.type.rawValue,
            "status": transaction.status
        ]
        
        return dict
    }
}
