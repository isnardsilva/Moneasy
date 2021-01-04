//
//  Transaction.swift
//  Moneasy
//
//  Created by Isnard Silva on 03/01/21.
//

import Foundation

enum TransactionType: String {
    case expense
    case revenue
}

struct Transaction {
    let uid: String
    let name: String
    let userUid: String
    let value: Double
    let description: String
    let date: Date
    let type: TransactionType
    let status: Bool // Despesa (está pago?) / Receita (recebido?)
    
    
    init(uid: String = UUID().uuidString, name: String, userUid: String, value: Double, description: String, date: Date, type: TransactionType, status: Bool) {
        self.uid = uid
        self.name = name
        self.userUid = userUid
        self.value = value
        self.description = description
        self.date = date
        self.type = type
        self.status = status
    }
}
