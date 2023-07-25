//
//  AuthAuthViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 08/03/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol AuthViewControllerProtocol: AnyObject {
    var presenter: AuthPresenterProtocol? { get set }
    
    func closeView()
    func showToastError(text: String)
    func showEmptyLogin()
    func showEmptyPassword()
}

class AuthViewController: BaseViewController {
    
    var presenter: AuthPresenterProtocol?
    
    let loginTextField: BaseTextField = {
        let view = BaseTextField()
        view.placeholder = "Login"
        return view
    }()
    
    let passwordTextField: BaseTextField = {
        let view = BaseTextField()
        view.placeholder = "Password"
        view.isSecureTextEntry = true
        return view
    }()
    
    let loginButton: BaseButton = {
        let view = BaseButton()
        view.set(style: .primary)
        view.setTitle("Войти", for: .normal)
        view.addTarget(nil, action: #selector(checkTextFieldAction), for: .touchUpInside)
        return view
    }()
    
    let registerButton: UIButton = {
        let view = UIButton()
        view.setTitle("Зарегистрироваться", for: .normal)
        view.titleLabel?.font = UIFont(name: "Montserrat", size: 13)
        view.addTarget(self, action: #selector(goToSignUpAction), for: .touchUpInside)
        return view
    }()
    
    let forgetAccountButton: UIButton = {
        let view = UIButton()
        view.setTitle("Зыбыл пароль", for: .normal)
        view.titleLabel?.font = UIFont(name: "Montserrat", size: 13)
        view.addTarget(self, action: #selector(goToResetPasswordAction), for: .touchUpInside)
        return view
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        return view
    }()
    
    let stackViewHorizontal: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.spacing = 16
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(stackViewHorizontal)
        stackViewHorizontal.addArrangedSubview(registerButton)
        stackViewHorizontal.addArrangedSubview(forgetAccountButton)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(view).offset(16)
            make.trailing.equalTo(view).offset(-16)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
}

extension AuthViewController {
    
    @objc func checkTextFieldAction(_ sender: Any) {
        view.endEditing(true)
        
        loginTextField.layer.borderColor = Palette.BorderField.primary.cgColor
        passwordTextField.layer.borderColor = Palette.BorderField.primary.cgColor
        
        presenter?.checkTextFieldEmpty(
            login: loginTextField.text,
            pass: passwordTextField.text
        )
    }
    
    @objc func goToSignUpAction() {
        presenter?.goToSignUp()
    }
    
    @objc func goToResetPasswordAction() {
        presenter?.goToResetPassword()
    }
}

extension AuthViewController: AuthViewControllerProtocol {
    
    func closeView() {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
    
    func showToastError(text: String) {
        toastAnimation(text: text) { [weak self] in
            self?.presenter?.checkTextFieldEmpty(
                login: self?.loginTextField.text,
                pass: self?.passwordTextField.text
            )
        }
    }
    
    func showEmptyLogin() {
        loginTextField.layer.borderColor = Palette.BorderField.wrong.cgColor
    }
    
    func showEmptyPassword() {
        passwordTextField.layer.borderColor = Palette.BorderField.wrong.cgColor
    }
}
