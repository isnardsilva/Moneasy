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
    let name: String
    let userUid: String
    let value: Double
    let description: String
    let date: Date
    let type: TransactionType
    let status: Bool // Despesa (está pago?) / Receita (recebido?)
}
