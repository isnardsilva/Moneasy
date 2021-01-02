//
//  LoginProtocol.swift
//  Moneasy
//
//  Created by Isnard Silva on 02/01/21.
//

import Foundation

protocol LoginProtocol {
    func authenticate(completionHandler: @escaping (Result<Void, Error>) -> Void)
}
