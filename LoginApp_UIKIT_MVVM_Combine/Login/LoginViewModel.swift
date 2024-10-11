//
//  LoginViewModel.swift
//  LoginApp_UIKIT_MVVM_Combine
//
//  Created by Juan Pablo Lasprilla Correa on 10/10/24.
//

import Foundation
import Combine

class LoginViewModel {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    var cancellables = Set<AnyCancellable>()
    
    let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
        
        formValidation()
    }
    
    func formValidation(){
        $email.sink{ value in
            print("Email: \(value)")
        }.store(in: &cancellables)
        
        $password.sink{ value in
            print("Password: \(value)")
        }.store(in: &cancellables)
        
    }
    
    @MainActor
    func userLogin(withEmail email: String, password: String){
        Task {
            do {
                let userModel = try await apiClient.login(withEmail: email, password: password)
            } catch let error as BackendError {
                print(error.localizedDescription)
            }
        }
    }
    
}
