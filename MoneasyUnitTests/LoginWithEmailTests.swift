//
//  LoginWithEmailTests.swift
//  MoneasyUnitTests
//
//  Created by Isnard Silva on 02/01/21.
//

import XCTest
@testable import Moneasy

final class LoginWithEmailTests: XCTestCase {
    // MARK: - Properties
    var sut: LoginWithEmail!
    
    
    // MARK: - Setup Methods
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        AuthManager().deleteUserSession(completionHandler: { error in
            if let detectedError = error {
                print(detectedError)
            }
        })
        super.tearDown()
    }
    
    
    // MARK: - Test Methods
    func testLoginWithValidEmailAndPassword() {
        // Given
        let validEmail = FirebaseSources.FakeUser.email
        let validPassword = FirebaseSources.FakeUser.password
        let promisse = expectation(description: "Call to Firebase Auth")
        
        // When
        sut = LoginWithEmail(email: validEmail, password: validPassword)
        sut.authenticate(completionHandler: { result in
            
            // Then
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
                
            case .success:
                promisse.fulfill()
            }
        })
        wait(for: [promisse], timeout: 5)
    }
    
    func testLoginWithInvalidEmail() {
        // Given
        let invalidEmail = "abc"
        let validPassword = FirebaseSources.FakeUser.password
        let expectedError: LoginWithEmailError = .invalidEmail
        var receivedError: Error?
        let promisse = expectation(description: "Call to Firebase Auth")
        
        // When
        sut = LoginWithEmail(email: invalidEmail, password: validPassword)
        sut.authenticate(completionHandler: { result in
            switch result {
            case .failure(let error):
                receivedError = error
                
            case .success:
                break
            }
            
            promisse.fulfill()
        })
        wait(for: [promisse], timeout: 5)
        
        // Then
        XCTAssertNotNil(receivedError)
        if let validReceivedError = receivedError as? LoginWithEmailError {
            XCTAssertEqual(validReceivedError, expectedError)
        } else {
            XCTFail("Invalid received error type")
        }
    }
    
    func testLoginWithWrongPassword() {
        // Given
        let validEmail = FirebaseSources.FakeUser.email
        let wrongPassword = "wrongPassword"
        let expectedError: LoginWithEmailError = .wrongPassword
        var receivedError: Error?
        let promisse = expectation(description: "Call to Firebase Auth")
        
        // When
        sut = LoginWithEmail(email: validEmail, password: wrongPassword)
        sut.authenticate(completionHandler: { result in
            switch result {
            case .failure(let error):
                receivedError = error
            case .success:
                break
            }
            promisse.fulfill()
        })
        wait(for: [promisse], timeout: 5)
        
        // Then
        XCTAssertNotNil(receivedError)
        if let validReceivedError = receivedError as? LoginWithEmailError {
            XCTAssertEqual(validReceivedError, expectedError)
        } else {
            XCTFail("Invalid received error type")
        }
    }
    
    func testLoginWithEmptyEmail() {
        // Given
        let expectedError: LoginWithEmailError = .emptyEmail
        var receivedError: Error?
        let promise = expectation(description: "Call to Firebase Auth")
        
        // When
        sut = LoginWithEmail(email: "", password: "anyPassword")
        sut.authenticate(completionHandler: { result in
            switch result {
            case .failure(let error):
                receivedError = error
            case .success:
                break
            }
            
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
        
        // Then
        XCTAssertNotNil(receivedError)
        if let validReceivedError = receivedError as? LoginWithEmailError {
            XCTAssertEqual(validReceivedError, expectedError)
        } else {
            XCTFail("Invalid received error type")
        }
    }
    
    func testLoginWithEmptyPassword() {
        // Given
        let expectedError: LoginWithEmailError = .emptyPassword
        var receivedError: Error?
        let promise = expectation(description: "Call to Firebase Auth")
        
        // When
        sut = LoginWithEmail(email: "anyemail@mail.com", password: "")
        sut.authenticate(completionHandler: { result in
            switch result {
            case .failure(let error):
                receivedError = error
            case .success:
                break
            }
            
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
        
        // Then
        XCTAssertNotNil(receivedError)
        if let validReceivedError = receivedError as? LoginWithEmailError {
            XCTAssertEqual(validReceivedError, expectedError)
        } else {
            XCTFail("Invalid received error type")
        }
    }
}
