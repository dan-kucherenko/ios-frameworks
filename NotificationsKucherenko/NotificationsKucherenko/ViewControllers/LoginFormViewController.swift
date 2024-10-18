//
//  LoginFormViewController.swift
//  NotificationsKucherenko
//
//  Created by Daniil Kucherenko on 18.10.2024.
//

import UIKit
import SnapKit

class LoginFormViewController: UIViewController {
    private let headerLabel = UILabel()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton(type: .system)
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupHeaderLabel()
        setupEmailTextField()
        setupPasswordTextField()
        setupStackView()
        setupLoginButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let credentials = AuthManager.shared.getCredentials(server: "example.com", email: "daniil.ukraine@gmail.com") {
            print("User is already logged in")
            print(credentials)
        }
    }
    
    @objc private func loginButtonTapped() {
        print("Login button tapped")
        AuthManager.shared.saveCredentials(
            server: "example.com",
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
    }
}

private extension LoginFormViewController {
    func setupHeaderLabel() {
        headerLabel.text = "MyTodos"
        headerLabel.font = .systemFont(ofSize: 32, weight: .semibold)
        headerLabel.textAlignment = .center
        view.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
        }
    }
    
    func setupEmailTextField() {
        emailTextField.placeholder = "Enter email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
    }
    
    func setupPasswordTextField() {
        passwordTextField.placeholder = "Enter password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.isSecureTextEntry = true
    }
    
    func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(100)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).inset(20)
            make.height.equalTo(120)
        }
    }
    
    func setupLoginButton() {
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = UIColor.systemBlue
        loginButton.layer.cornerRadius = 10
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(view).inset(60)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
    }
}
