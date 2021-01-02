//
//  LoginWithEmail.swift
//  Moneasy
//
//  Created by Isnard Silva on 02/01/21.
//

import Firebase

class LoginWithEmail {
    // MARK: - Properties
    private let email: String
    private let password: String
    
    // MARK: - Initialization
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

// MARK: - Validation Methods
extension LoginWithEmail {
    private func checkEmailIsValid() throws {
        if email.isEmpty {
            throw LoginWithEmailError.emptyEmail
        }
    }
    
    private func checkPasswordIsValid() throws {
        if password.isEmpty {
            throw LoginWithEmailError.emptyPassword
        }
    }
}


// MARK: - LoginProtocol
extension LoginWithEmail: LoginProtocol {
    func authenticate(completionHandler: @escaping (Result<Void, Error>) -> Void) {
        // Check infos
        do {
            try self.checkEmailIsValid()
            try self.checkPasswordIsValid()
        } catch {
            completionHandler(.failure(error))
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { _, error in
            if let detectedError = error {
                completionHandler(.failure(self.handleLoginErrors(detectedError)))
                return
            }
            
            completionHandler(.success(()))
        })
    }
}


// MARK: - Handle Login Errors
extension LoginWithEmail {
    private func handleLoginErrors(_ error: Error) -> LoginWithEmailError {
        let detectedNSError = error as NSError
        
        switch detectedNSError.code {
        case FirebaseAuthErrorCode.wrongPassword.rawValue:
            return .wrongPassword
        case FirebaseAuthErrorCode.userNotFound.rawValue:
            return .userNotFound
        case FirebaseAuthErrorCode.invalidEmail.rawValue:
            return .invalidEmail
        case FirebaseAuthErrorCode.offline.rawValue:
            return .offline
        default:
            return .unknowError
        }
    }
}
