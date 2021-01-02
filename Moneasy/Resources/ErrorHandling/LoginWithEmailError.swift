//
//  LoginWithEmailError.swift
//  Moneasy
//
//  Created by Isnard Silva on 02/01/21.
//

import Foundation

enum LoginWithEmailError: Error {
    case invalidEmail
    case emptyEmail
    case emptyPassword
    case wrongPassword
    case userNotFound
    case offline
    case unknowError
}


// MARK: - LocalizedError
extension LoginWithEmailError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "Insira um e-mail válido."
        case .emptyEmail:
            return "Insira um e-mail."
        case .emptyPassword:
            return "Insira uma senha."
        case .wrongPassword:
            return "A senha está incorreta."
        case .userNotFound:
            return "Não foi encontrado nenhum usuário com esse e-mail."
        case .offline:
            return "Não há conexão com a internet."
        case .unknowError:
            return "Ocorreu um erro desconhecido. Tente novamente!"
        }
    }
}
