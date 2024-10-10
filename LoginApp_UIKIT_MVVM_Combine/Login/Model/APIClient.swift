//
//  APIClient.swift
//  LoginApp_UIKIT_MVVM_Combine
//
//  Created by Juan Pablo Lasprilla Correa on 10/10/24.
//

import Foundation

enum BackendError: String, Error {
    case invalidEmail = "check your email"
    case invalidPassword = "check your password"
}

final class APIClient {
    func login(withEmail email: String, password: String) async throws -> User {
        //Simulated HTTP request and wait 2 seconds
        try await Task.sleep(nanoseconds: NSEC_PER_SEC * 2)
        return try simulateBackendLogic(email: email, password: password)
    }
}

func simulateBackendLogic(email: String, password: String) throws -> User {
    guard email == "swiftbeta.blog@gmail.com" else {
        print("The user isn't SwiftBeta")
        throw BackendError.invalidEmail
    }
    
    guard password == "12345" else {
        print("The password isn't correct")
        throw BackendError.invalidPassword
    }
    
    print("Succes")
    return .init(name: "SwiftBeta", token: "token_12345", session: .now)
}
