//
//  AuthAuthViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 08/03/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit
import Lottie

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
        view.placeholder = "Логин"
        return view
    }()
    
    let passwordTextField: BaseTextField = {
        let view = BaseTextField()
        view.placeholder = "Пароль"
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
        view.setTitle("Забыл пароль", for: .normal)
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
    
    let contentLoginView: UIView = {
        let view = UIView()
        return view
    }()
    
    let blurEffect = UIBlurEffect(style: .dark)
    let blurredEffectView = UIVisualEffectView()
    let backAuthView = BackAuthView()
    private let spinnerView = LottieAnimationView(name: "loader")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupThirdParty()
        setupSubviews()
        setupConstraints()
        registerKeyboardNotifications()
        settingSpinner()
    }
    
    private func setupThirdParty() {
        let text = [
            "Интернет магазин",
            "Покупка товаров",
            "Продажа товаров",
            "Ищите товары",
            "Открывайте магазин бесплатно",
            "Никаких подписок",
            "Продавайте эффективнее",
            "Товары всегда найдутся",
            "Товары дешевле"
        ]
        
        backAuthView.setupCell(text: text, width: view.frame.size.width)
        blurredEffectView.effect = blurEffect
    }
    
    private func settingSpinner() {
        spinnerView.contentMode = .scaleAspectFill
        spinnerView.loopMode = .loop
        spinnerView.animationSpeed = 2
        
        showLoader(enable: false)
    }
    
    private func setupSubviews() {
        view.addSubview(backAuthView)
        view.addSubview(contentLoginView)
        contentLoginView.addSubview(blurredEffectView)
        contentLoginView.addSubview(stackView)
        contentLoginView.addSubview(spinnerView)
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(stackViewHorizontal)
        stackViewHorizontal.addArrangedSubview(registerButton)
        stackViewHorizontal.addArrangedSubview(forgetAccountButton)
    }
    
    private func setupConstraints() {
        backAuthView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        contentLoginView.snp.makeConstraints { make in
            make.height.equalTo(250)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        spinnerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        blurredEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
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
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func showLoader(enable: Bool) {
        if enable {
            spinnerView.play()
        } else {
            spinnerView.stop()
        }
        
        stackView.alpha = enable ? 0.5 : 1
        spinnerView.isHidden = !enable
        loginTextField.isEnabled = !enable
        passwordTextField.isEnabled = !enable
        loginButton.isEnabled = !enable
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            contentLoginView.snp.updateConstraints { make in
                make.height.equalTo(self.view.frame.height - keyboardHeight)
            }
        }
         
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        
        contentLoginView.snp.updateConstraints { make in
            make.height.equalTo(250)
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func checkTextFieldAction(_ sender: Any) {
        view.endEditing(true)
        
        showLoader(enable: true)
        
        loginTextField.layer.borderColor = Palette.BorderField.primary.cgColor
        passwordTextField.layer.borderColor = Palette.BorderField.primary.cgColor
        
        presenter?.checkTextFieldEmpty(
            login: loginTextField.text,
            pass: passwordTextField.text
        )
    }
    
    @objc private func goToSignUpAction() {
        presenter?.goToSignUp()
    }
    
    @objc private func goToResetPasswordAction() {
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
        
        showLoader(enable: false)
    }
    
    func showEmptyLogin() {
        loginTextField.layer.borderColor = Palette.BorderField.wrong.cgColor
        
        showLoader(enable: false)
    }
    
    func showEmptyPassword() {
        passwordTextField.layer.borderColor = Palette.BorderField.wrong.cgColor
        
        showLoader(enable: false)
    }
}
