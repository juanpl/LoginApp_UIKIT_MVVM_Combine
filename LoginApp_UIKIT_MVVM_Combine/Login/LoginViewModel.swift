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
    @Published var isEnabled: Bool = false
    @Published var showLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var userModel: User?
    
    var cancellables = Set<AnyCancellable>()
    
    let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
        
        formValidation()
    }
    
    func formValidation(){
        Publishers.CombineLatest($email, $password)
            .filter { email, password in
                return email.count > 5 && password.count > 5
            }.sink {value in
                self.isEnabled = true
            }.store(in: &cancellables)
    }
    
    @MainActor
    func userLogin(withEmail email: String, password: String){
        
        errorMessage = ""
        showLoading = true
        
        Task {
            do {
                userModel = try await apiClient.login(withEmail: email, password: password)
            } catch let error as BackendError {
                errorMessage = error.rawValue
            }
            
        showLoading = false
            
        }
    }
    
}
