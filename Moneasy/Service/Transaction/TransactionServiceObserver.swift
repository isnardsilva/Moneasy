//
//  TransactionServiceObserver.swift
//  Moneasy
//
//  Created by Isnard Silva on 03/01/21.
//

import Foundation

protocol TransactionServiceObserver: class {
    func update()
}

extension Notification.Name {
    static let TransactionServiceUpdated = Notification.Name("TransactionServiceUpdated")
}
