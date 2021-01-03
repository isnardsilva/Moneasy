//
//  AuthManagerError.swift
//  Moneasy
//
//  Created by Isnard Silva on 03/01/21.
//

import Foundation

enum AuthManagerError: Error {
    case unauthenticatedUser
    case signOutFailed
}


// MARK: - LocalizedError
extension AuthManagerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unauthenticatedUser:
            return "Falha na autenticação do usuário."
        case .signOutFailed:
            return "Erro ao tentar fazer logout."
        }
    }
}
