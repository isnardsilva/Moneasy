//
//  LoginViewModel.swift
//  Moneasy
//
//  Created by Isnard Silva on 02/01/21.
//

import Foundation

final class LoginViewModel {
    // MARK: - Properties
    var didLoginSuccess: (() -> Void)?
    var didLoginError: ((Error) -> Void)?
    
    
    // MARK: - Auth Method
    func authenticate(loginMethod: LoginProtocol) {
        loginMethod.authenticate(completionHandler: { [weak self] result in
            switch result {
            case .failure(let error):
                self?.didLoginError?(error)
            case .success:
                self?.didLoginSuccess?()
            }
        })
    }
}
