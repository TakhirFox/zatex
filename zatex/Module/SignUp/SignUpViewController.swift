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
            make.edges.equalToSuperview()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = RowKind(rawValue: indexPath.row)
        switch row {
        case .username:
            let cell = tableView.dequeueReusableCell(withIdentifier: "usernameFieldCell", for: indexPath) as! FieldSignUpCell
            cell.textField.addTarget(self, action: #selector(usernameDidChange(_:)), for: .editingChanged)
            cell.setupCell(name: "Имя пользователя", field: "")
            return cell
            
        case .email:
            let cell = tableView.dequeueReusableCell(withIdentifier: "emailFieldCell", for: indexPath) as! FieldSignUpCell
            cell.textField.addTarget(self, action: #selector(emailDidChange(_:)), for: .editingChanged)
            cell.setupCell(name: "Email", field: "")
            return cell
            
        case .password:
            let cell = tableView.dequeueReusableCell(withIdentifier: "passwordFieldCell", for: indexPath) as! FieldSignUpCell
            cell.textField.addTarget(self, action: #selector(passwordDidChange(_:)), for: .editingChanged)
            cell.textField.isSecureTextEntry = true
            cell.setupCell(name: "Password", field: "")
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
        presenter?.checkTextFieldEmpty(
            username: signUpData.username,
            email: signUpData.email,
            pass: signUpData.pass
        )
    }
}

extension SignUpViewController: SignUpViewControllerProtocol {
   
}
