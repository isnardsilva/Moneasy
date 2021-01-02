//
//  FirebaseSources.swift
//  Moneasy
//
//  Created by Isnard Silva on 02/01/21.
//

import Foundation

enum FirebaseAuthErrorCode: Int {
    case invalidEmail = 17008
    case wrongPassword = 17009
    case userNotFound = 17011
    case offline = 17020
}

enum FirebaseSources {
    enum FakeUser {
        static let email = "testeios@mail.com"
        static let password = "123456"
    }
}
