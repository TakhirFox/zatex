//
//  SignUpSignUpViewController.swift
//  zatex
//
//  Created by winzero on 28/05/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol SignUpViewControllerProtocol: AnyObject {
    var presenter: SignUpPresenterProtocol? { get set }
    
    func showToastError(text: String)
    func showEmptyUsername()
    func showEmptyEmail()
    func showEmptyPassword()
}

class SignUpViewController: BaseViewController {
    
    enum RowKind: Int {
        case username, email, password, send
    }
    
    var presenter: SignUpPresenterProtocol?
    
    var signUpData = SignUpEntity()
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupTableView()
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupTableView() {
        title = "Регистрация"
        
        tableView.register(FieldSignUpCell.self, forCellReuseIdentifier: "usernameFieldCell")
        tableView.register(FieldSignUpCell.self, forCellReuseIdentifier: "emailFieldCell")
        tableView.register(FieldSignUpCell.self, forCellReuseIdentifier: "passwordFieldCell")
        tableView.register(SignUpButtonCell.self, forCellReuseIdentifier: "signUpButtonCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
}

extension SignUpViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 4
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let row = RowKind(rawValue: indexPath.row)
        switch row {
        case .username:
            let cell = tableView.dequeueReusableCell(withIdentifier: "usernameFieldCell", for: indexPath) as! FieldSignUpCell
            cell.textField.addTarget(self, action: #selector(usernameDidChange(_:)), for: .editingChanged)
            cell.setupCell(name: "Логин", field: "")
            return cell
            
        case .email:
            let cell = tableView.dequeueReusableCell(withIdentifier: "emailFieldCell", for: indexPath) as! FieldSignUpCell
            cell.textField.addTarget(self, action: #selector(emailDidChange(_:)), for: .editingChanged)
            cell.setupCell(name: "Почта", field: "")
            cell.textField.keyboardType = .emailAddress
            return cell
            
        case .password:
            let cell = tableView.dequeueReusableCell(withIdentifier: "passwordFieldCell", for: indexPath) as! FieldSignUpCell
            cell.textField.addTarget(self, action: #selector(passwordDidChange(_:)), for: .editingChanged)
            cell.textField.isSecureTextEntry = true
            cell.setupCell(name: "Пароль", field: "")
            return cell
            
        case .send:
            let cell = tableView.dequeueReusableCell(withIdentifier: "signUpButtonCell", for: indexPath) as! SignUpButtonCell
            cell.sendButton.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
            cell.setupCell(name: "Зарегистрировать")
            return cell
            
        case .none:
            return UITableViewCell()
        }
    }
}

extension SignUpViewController {
    
    @objc func usernameDidChange(_ textField: UITextField) {
        if textField.text != nil {
            signUpData.username = textField.text
        }
    }
    
    @objc func emailDidChange(_ textField: UITextField) {
        if textField.text != nil {
            signUpData.email = textField.text
        }
    }
    
    @objc func passwordDidChange(_ textField: UITextField) {
        if textField.text != nil {
            signUpData.pass = textField.text
        }
    }
    
    @objc func signUpAction() {
        for index in 0..<3 {
            setStandartColorToTextField(index: index)
        }
        
        showLoader(enable: true)
        
        presenter?.checkTextFieldEmpty(
            username: signUpData.username,
            email: signUpData.email,
            pass: signUpData.pass
        )
    }
    
    private func setStandartColorToTextField(index: Int) {
        guard let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? FieldSignUpCell else { return }
        cell.textField.layer.borderColor = Palette.BorderField.primary.cgColor
    }
    
    private func showLoader(enable: Bool) {
        if enable {
            loaderView.play()
        } else {
            loaderView.stop()
        }
        
        loaderView.isHidden = !enable
        tableView.alpha = enable ? 0.5 : 1
        tableView.isUserInteractionEnabled = !enable
    }
}

extension SignUpViewController: SignUpViewControllerProtocol {
    
    func showToastError(text: String) {
        toastAnimation(text: text) { [weak self] in
            self?.presenter?.checkTextFieldEmpty(
                username: self?.signUpData.username,
                email: self?.signUpData.email,
                pass: self?.signUpData.pass
            )
            
            self?.showLoader(enable: true)
        }
        
        showLoader(enable: false)
    }
    
    func showEmptyUsername() {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? FieldSignUpCell else { return }
        cell.textField.layer.borderColor = Palette.BorderField.wrong.cgColor
        
        showLoader(enable: false)
    }
    
    func showEmptyEmail() {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? FieldSignUpCell else { return }
        cell.textField.layer.borderColor = Palette.BorderField.wrong.cgColor
        
        showLoader(enable: false)
    }
    
    func showEmptyPassword() {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? FieldSignUpCell else { return }
        cell.textField.layer.borderColor = Palette.BorderField.wrong.cgColor
        
        showLoader(enable: false)
    }
}
