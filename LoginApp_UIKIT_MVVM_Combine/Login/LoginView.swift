//
//  ViewController.swift
//  LoginApp_UIKIT_MVVM_Combine
//
//  Created by Juan Pablo Lasprilla Correa on 9/10/24.
//

import UIKit

class LoginView: UIViewController {

    private let loginViewModel = LoginViewModel(apiClient: APIClient())
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Add Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Add Password"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Login"
        configuration.subtitle = "Suscribe to SwiftBeta!"
        configuration.image = UIImage(systemName: "play.circle.fill")
        configuration.imagePadding = 8
        
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { [weak self] action in
            self?.startLogin()
        }))
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = configuration
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [emailTextField, passwordTextField, loginButton].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -20),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            passwordTextField.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -32),
            passwordTextField.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -20),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func startLogin() {
        loginViewModel.userLogin(withEmail:emailTextField.text?.lowercased() ?? "", password: passwordTextField.text?.lowercased() ?? "")
        
    }


}

