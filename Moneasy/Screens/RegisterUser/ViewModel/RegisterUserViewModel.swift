//
//  RegisterUserViewModel.swift
//  Moneasy
//
//  Created by Isnard Silva on 04/01/21.
//

import Foundation

class RegisterUserViewModel {
    // MARK: - Properties
    private let userService = UserService()
    
    var didRegisterUserSuccess: (() -> Void)?
    var didRegisterUserError: ((Error) -> Void)?
    
    
    // MARK: Service Methods
    func createUser(email: String, password: String) {
        userService.createUser(email: email, password: password, completionHandler: { [weak self] error in
            if let detectedError = error {
                self?.didRegisterUserError?(detectedError)
            } else {
                self?.didRegisterUserSuccess?()
            }
        })
    }
}
