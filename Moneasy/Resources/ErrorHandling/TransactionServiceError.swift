//
//  TransactionServiceError.swift
//  Moneasy
//
//  Created by Isnard Silva on 03/01/21.
//

import Foundation

enum TransactionServiceError: Error {
    case objectNotDecoded
    case emptyResponse
}


// MARK: - LocalizedError
extension TransactionServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .objectNotDecoded:
            return "Não foi possível decodificar o objeto."
            
        case .emptyResponse:
            return "Foi obtida uma resposta vazia do servidor."
        }
    }
}
