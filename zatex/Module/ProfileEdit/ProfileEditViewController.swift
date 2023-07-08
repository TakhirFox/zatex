//
//  ProfileEditProfileEditViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol ProfileEditViewControllerProtocol: AnyObject {
    var presenter: ProfileEditPresenterProtocol? { get set }
    
    func setProfileInfo(data: StoreInfoResult)
    func successUpdateInfo()
}

class ProfileEditViewController: BaseViewController {
    
    enum RowKind: Int {
        case avatar, firstName, secondName, address, numberPhone, email, shopMode
    }
    
    enum RowTwoKind: Int {
        case shopName, colorName, shopImage
    }
    
    var presenter: ProfileEditPresenterProtocol?
    
    var sessionProvider: SessionProvider?
    var profileInfo: StoreInfoResult?
    
    var isShopMode = false
    
    let successView = SuccessUpdateProfileView()
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let userId = sessionProvider?.getSession()?.userId,
            let id = Int(userId) {
            presenter?.getProfileInfo(id: id)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSubviews()
        setupConstraints()
        setupSuccessView()
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
        title = "Редактировать профиль"
        
        tableView.register(AvatarEditCell.self, forCellReuseIdentifier: "avatarCell")
        tableView.register(FieldEditCell.self, forCellReuseIdentifier: "firstNameFieldCell")
        tableView.register(FieldEditCell.self, forCellReuseIdentifier: "lastNameFieldCell")
        tableView.register(FieldEditCell.self, forCellReuseIdentifier: "addressFieldCell")
        tableView.register(FieldEditCell.self, forCellReuseIdentifier: "phoneFieldCell")
        tableView.register(FieldEditCell.self, forCellReuseIdentifier: "emailFieldCell")
        tableView.register(FieldEditCell.self, forCellReuseIdentifier: "storeNaMeFieldCell")
        tableView.register(CheckboxEditCell.self, forCellReuseIdentifier: "storeModeBoxCell")
        tableView.register(CheckboxEditCell.self, forCellReuseIdentifier: "shopThemeBoxCell")
        tableView.register(BackImageCell.self, forCellReuseIdentifier: "backCell")
        tableView.register(ProfileEditButtonCell.self, forCellReuseIdentifier: "buttonCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    private func setupSuccessView() {
        successView.isHidden = true
        successView.okButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
    }
    
}

extension ProfileEditViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return isShopMode ? 3 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 7
        } else if section == 1 {
            return 3
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let row = RowKind(rawValue: indexPath.row)
            switch row {
            case .avatar:
                let cell = tableView.dequeueReusableCell(withIdentifier: "avatarCell", for: indexPath) as! AvatarEditCell
                cell.setupCell(image: profileInfo?.gravatar)
                return cell
                
            case .firstName:
                let cell = tableView.dequeueReusableCell(withIdentifier: "firstNameFieldCell", for: indexPath) as! FieldEditCell
                cell.setupCell(name: "Имя", field: profileInfo?.firstName ?? "")
                cell.textField.addTarget(self, action: #selector(firstNameDidChange(_:)), for: .editingChanged)
                cell.textField.delegate = self
                return cell
                
            case .secondName:
                let cell = tableView.dequeueReusableCell(withIdentifier: "lastNameFieldCell", for: indexPath) as! FieldEditCell
                cell.setupCell(name: "Фамилия", field: profileInfo?.lastName ?? "")
                cell.textField.addTarget(self, action: #selector(lastNameDidChange(_:)), for: .editingChanged)
                cell.textField.delegate = self
                return cell
                
            case .address:
                let cell = tableView.dequeueReusableCell(withIdentifier: "addressFieldCell", for: indexPath) as! FieldEditCell
                cell.setupCell(name: "Адрес", field: "profileInfo?.address[0]")
                cell.textField.addTarget(self, action: #selector(addressDidChange(_:)), for: .editingChanged)
                cell.textField.delegate = self
                return cell
                
            case .numberPhone:
                let cell = tableView.dequeueReusableCell(withIdentifier: "phoneFieldCell", for: indexPath) as! FieldEditCell
                cell.setupCell(name: "Номер телефона", field: profileInfo?.phone ?? "")
                cell.textField.addTarget(self, action: #selector(numberPhoneDidChange(_:)), for: .editingChanged)
                cell.textField.delegate = self
                return cell
                
            case .email:
                let cell = tableView.dequeueReusableCell(withIdentifier: "emailFieldCell", for: indexPath) as! FieldEditCell
                cell.setupCell(name: "Email", field: profileInfo?.email ?? "")
                cell.textField.addTarget(self, action: #selector(emailDidChange(_:)), for: .editingChanged)
                cell.textField.delegate = self
                return cell
                
            case .shopMode:
                let cell = tableView.dequeueReusableCell(withIdentifier: "storeModeBoxCell", for: indexPath) as! CheckboxEditCell
                cell.setupCell(name: "Режим магазина", firstName: "Магазин", secondName: "Частная торговля")
                isShopMode = cell.isFirstSelected
                cell.updateView = {
                    self.tableView.reloadData()
                }
                return cell
                
            case .none:
                return UITableViewCell()
                
            }
        } else if indexPath.section == 1 {
            let row = RowTwoKind(rawValue: indexPath.row)
            switch row {
            case .shopName:
                let cell = tableView.dequeueReusableCell(withIdentifier: "storeNaMeFieldCell", for: indexPath) as! FieldEditCell
                cell.setupCell(name: "Название магазина", field: profileInfo?.storeName ?? "")
                cell.textField.addTarget(self, action: #selector(storeNameDidChange(_:)), for: .editingChanged)
                cell.textField.delegate = self
                return cell
                
            case .colorName:
                let cell = tableView.dequeueReusableCell(withIdentifier: "shopThemeBoxCell", for: indexPath) as! CheckboxEditCell
                cell.setupCell(name: "Цвет названия", firstName: "Светлый", secondName: "Темный")
                return cell
                
            case .shopImage:
                let cell = tableView.dequeueReusableCell(withIdentifier: "backCell", for: indexPath) as! BackImageCell
                cell.setupCell(name: "Фон магазина", image: profileInfo?.banner)
                return cell
                
            case .none:
                return UITableViewCell()
                
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! ProfileEditButtonCell
            cell.setupCell(name: "Сохранить")
            cell.sendButton.addTarget(self, action: #selector(updateInformation), for: .touchUpInside)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderCell()
        
        if section == 0 {
            headerView.setupCell("Основная информация")
        } else {
            headerView.setupCell("Информация магазина")
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension ProfileEditViewController: UITextFieldDelegate {}

extension ProfileEditViewController {
    
    @objc func updateInformation() {
        presenter?.updateProfileInfo(data: profileInfo)
    }
    
    @objc func firstNameDidChange(_ textField: UITextField) {
        if textField.text != nil {
            profileInfo?.firstName = textField.text
        }
    }
    
    @objc func lastNameDidChange(_ textField: UITextField) {
        if textField.text != nil {
            profileInfo?.lastName = textField.text
        }
    }
    
    @objc func addressDidChange(_ textField: UITextField) {
        if textField.text != nil {
//            profileInfo?.address = textField.text // TODO: change
        }
    }
    
    @objc func numberPhoneDidChange(_ textField: UITextField) {
        if textField.text != nil {
            profileInfo?.phone = textField.text
        }
    }
    
    @objc func emailDidChange(_ textField: UITextField) {
        if textField.text != nil {
            profileInfo?.email = textField.text
        }
    }
    
    @objc func storeNameDidChange(_ textField: UITextField) {
        if textField.text != nil {
            profileInfo?.storeName = textField.text
        }
    }
    
    @objc func closeView() {
        navigationController?.popViewController(animated: true)
    }
}

extension ProfileEditViewController: ProfileEditViewControllerProtocol {
   
    func setProfileInfo(data: StoreInfoResult) {
        DispatchQueue.main.async { [weak self] in
            self?.profileInfo = data
            self?.tableView.reloadData()
        }
    }
    
    func successUpdateInfo() {
        successView.isHidden = false
    }
}
