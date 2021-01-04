//
//  UserService.swift
//  Moneasy
//
//  Created by Isnard Silva on 04/01/21.
//

import Firebase

class UserService {
    
    // MARK: - CRUD Methods
    func createUser(email: String, password: String, completionHandler: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] _, error in
            if let detectedError = error {
                completionHandler(self?.handleCreateUserErrors(detectedError))
            }
        })
    }
}

// MARK: - Handle Login Errors
extension UserService {
    private func handleCreateUserErrors(_ error: Error) -> UserServiceError {
        let detectedNSError = error as NSError
        
        switch detectedNSError.code {
        case FirebaseAuthErrorCode.emailAlreadyExists.rawValue:
            return .emailAlreadyExists
        case FirebaseAuthErrorCode.invalidEmail.rawValue:
            return .invalidEmail
        case FirebaseAuthErrorCode.offline.rawValue:
            return .offline
        default:
            return .unknowError
        }
    }
}
