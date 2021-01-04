//
//  UserServiceError.swift
//  Moneasy
//
//  Created by Isnard Silva on 04/01/21.
//

import Foundation

enum UserServiceError: Error {
    case invalidEmail
    case emptyEmail
    case emailAlreadyExists
    case emptyPassword
    case offline
    case unknowError
}

extension UserServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "Insira um e-mail válido."
        case .emptyEmail:
            return "Insira um e-mail."
        case .emptyPassword:
            return "Insira uma senha."
        case .emailAlreadyExists:
            return "Esse endereço de e-mail já existe."
        case .offline:
            return "Não há conexão com a internet."
        case .unknowError:
            return "Ocorreu um erro desconhecido. Tente novamente!"
        }
    }
}
