//
//  ResetPasswordResetPasswordViewController.swift
//  zatex
//
//  Created by winzero on 30/05/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol ResetPasswordViewControllerProtocol: AnyObject {
    var presenter: ResetPasswordPresenterProtocol? { get set }
    
    func showSuccess()
    func showToastError(text: String)
    func showEmptyUsername()
}

class ResetPasswordViewController: BaseViewController {
    
    enum RowKind: Int {
        case username, send
    }
    
    var presenter: ResetPasswordPresenterProtocol?
    
    var username = ""
    
    let successView = SuccessResetPasswordView()
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSubviews()
        setupConstraints()
        setSuccessView()
    }
    
    func setupSubviews() {
        view.addSubview(tableView)
        view.addSubview(successView)
    }
    
    func setupConstraints() {
        successView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupTableView() {
        title = "Сброс пароля"
        
        tableView.register(FieldSignUpCell.self, forCellReuseIdentifier: "usernameFieldCell")
        tableView.register(SignUpButtonCell.self, forCellReuseIdentifier: "signUpButtonCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    private func setSuccessView() {
        successView.isHidden = true
        successView.okButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
    }
}

extension ResetPasswordViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = RowKind(rawValue: indexPath.row)
        switch row {
        case .username:
            let cell = tableView.dequeueReusableCell(withIdentifier: "usernameFieldCell", for: indexPath) as! FieldSignUpCell
            cell.textField.addTarget(self, action: #selector(usernameDidChange(_:)), for: .editingChanged)
            cell.setupCell(name: "Имя пользователя", field: "")
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

extension ResetPasswordViewController {
    @objc func usernameDidChange(_ textField: UITextField) {
        if textField.text != nil {
            username = textField.text ?? ""
        }
    }
    
    @objc func signUpAction() {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? FieldSignUpCell else { return }
        cell.textField.layer.borderColor = Palette.BorderField.primary.cgColor
        
        showLoader(enable: true)
        
        presenter?.checkTextFieldEmpty(
            username: username
        )
    }
    
    @objc func closeView() {
        navigationController?.popViewController(animated: true)
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

extension ResetPasswordViewController: ResetPasswordViewControllerProtocol {
    
    func showSuccess() {
        successView.isHidden = false
        
        showLoader(enable: false)
    }
    
    func showToastError(text: String) {
        toastAnimation(text: text) { [weak self] in
            self?.presenter?.checkTextFieldEmpty(
                username: self?.username
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
}
