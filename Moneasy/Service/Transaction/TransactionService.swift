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
        var detectedError: Error?
        
        database.collection(Identifier.Database.transactionsKey).addDocument(data: dictTransaction, completion: { error in
            detectedError = error
        })
        
        completionHandler(detectedError)
        if detectedError == nil {
            NotificationCenter.default.post(name: .TransactionServiceUpdated, object: nil)
        }
    }
    
    func fetchTransactions(completionHandler: @escaping (Result<[Transaction], Error>) -> Void) {
        // Get User Uid
        AuthManager().getUserUid(completionHandler: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
                
            case .success(let userUid):
                self.getTransactionsFromUserUid(userUid: userUid, completion: { result in
                    completionHandler(result)
                })
            }
        })
    }
    
    func fetchTransactionsOrderByDate(completionHandler: @escaping (Result<[Transaction], Error>) -> Void) {
        fetchTransactions(completionHandler: { result in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
                
            case .success(var transactions):
                transactions.sort(by: { $0.date > $1.date })
                completionHandler(.success(transactions))
            }
        })
    }
    
    func updateTransaction(_ transaction: Transaction, completionHandler: @escaping (Error?) -> Void) {
        // Get reference to transaction
        database.collection(Identifier.Database.transactionsKey).whereField("uid", isEqualTo: transaction.uid).getDocuments(completion: { [weak self] (snapshot, error) in
            
            guard let self = self else { return }
            
            if let detectedError = error {
                completionHandler(detectedError)
                return
            }

            guard let validSnapshot = snapshot,
                  let validDocument = validSnapshot.documents.first else {
                completionHandler(TransactionServiceError.emptyResponse)
                return
            }
            
            let dictTransaction = self.convertTransactionObjectToDictionary(transaction)
            
            var detectedError: Error?
            validDocument.reference.updateData(dictTransaction, completion: { error in
                detectedError = error
            })
            
            completionHandler(detectedError)
            if detectedError == nil {
                NotificationCenter.default.post(name: .TransactionServiceUpdated, object: nil)
            }
        })
    }
    
    func deleteTransaction(_ transaction: Transaction, completionHandler: @escaping (Error) -> Void) {
        
    }
}


// MARK: - Helper Methods
extension TransactionService {
    private func getTransactionsFromUserUid(userUid: String, completion: @escaping (Result<[Transaction], Error>) -> Void) {
        database.collection(Identifier.Database.transactionsKey).whereField("userUid", isEqualTo: userUid).getDocuments(completion: { (snapshot, error) in
            
            if let detectedError = error {
                completion(.failure(detectedError))
                return
            }

            guard let validSnapshot = snapshot else {
                completion(.failure(TransactionServiceError.emptyResponse))
                return
            }
            
            do {
                let transactions = try self.handleFetchTransactionsResponse(snapshot: validSnapshot)
                completion(.success(transactions))
            } catch {
                completion(.failure(error))
            }
        })
    }
    
    private func handleFetchTransactionsResponse(snapshot: QuerySnapshot) throws -> [Transaction] {
        var transactions: [Transaction] = []
        
        for document in snapshot.documents {
            if let transaction = self.convertDictionaryObjectToTransaction(dict: document.data()) {
                transactions.append(transaction)
            } else {
                throw TransactionServiceError.objectNotDecoded
            }
        }
        
        return transactions
    }
    
    private func convertTransactionObjectToDictionary(_ transaction: Transaction) -> [String: Any] {
        let dict: [String: Any] = [
            "uid": transaction.uid,
            "name": transaction.name,
            "userUid": transaction.userUid,
            "value": transaction.value,
            "description": transaction.description,
            "date": transaction.date.toString(withFormat: "yyyy-MM-dd"),
            "type": transaction.type.rawValue,
            "status": transaction.status
        ]
        
        return dict
    }
    
    private func convertDictionaryObjectToTransaction(dict: [String: Any]) -> Transaction? {
        guard let uid = dict["uid"] as? String,
              let name = dict["name"] as? String,
              let userUid = dict["userUid"] as? String,
              let value = dict["value"] as? Double,
              let description = dict["description"] as? String,
              let strDate = dict["date"] as? String,
              let strType = dict["type"] as? String,
              let status = dict["status"] as? Bool else {
            
            print("Erro no dicionário")
            return nil
        }
        
        guard let date = strDate.toDate(withFormat: "yyyy-MM-dd") else {
            print("Erro na data")
            return nil
        }
        
        var transactionType: TransactionType?
        
        switch strType {
        case TransactionType.expense.rawValue:
            transactionType = .expense
            
        case TransactionType.revenue.rawValue:
            transactionType = .revenue
            
        default:
            break
        }
        
        guard let validTransactionType = transactionType else {
            print("Erro no transaction type")
            return nil
        }
        
        let transaction = Transaction(uid: uid, name: name, userUid: userUid, value: value, description: description, date: date, type: validTransactionType, status: status)
        
        return transaction
    }
}
