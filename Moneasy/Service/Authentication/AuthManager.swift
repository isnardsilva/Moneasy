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
    
    func deleteUserSession(completionHandler: (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completionHandler(nil)
        } catch {
            completionHandler(error)
        }
    }
}
