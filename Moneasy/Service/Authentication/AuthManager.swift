//
//  AuthManager.swift
//  Moneasy
//
//  Created by Isnard Silva on 02/01/21.
//

import Firebase

final class AuthManager {
    
    func checkIsAuthenticated(completionHandler: @escaping (_ success: Bool) -> Void) {
        // Check if is authenticated
        Auth.auth().addStateDidChangeListener({ _, user in
            if user != nil {
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        })
    }
    
    func getUserUid(completionHandler: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().addStateDidChangeListener({ _, user in
            if let validUser = user {
                completionHandler(.success(validUser.uid))
            } else {
                completionHandler(.failure(AuthManagerError.unauthenticatedUser))
            }
        })
    }
    
    func deleteUserSession(completionHandler: (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completionHandler(nil)
        } catch {
            completionHandler(AuthManagerError.signOutFailed)
        }
    }
}
