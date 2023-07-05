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
        title = "Редактировать профиль"
        
        tableView.register(AvatarEditCell.self, forCellReuseIdentifier: "avatarCell")
        tableView.register(FieldEditCell.self, forCellReuseIdentifier: "fieldCell")
        tableView.register(CheckboxEditCell.self, forCellReuseIdentifier: "boxCell")
        tableView.register(BackImageCell.self, forCellReuseIdentifier: "backCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
}

extension ProfileEditViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return isShopMode ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 7
        } else {
            return 3
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "fieldCell", for: indexPath) as! FieldEditCell
                cell.setupCell(name: "Имя", field: profileInfo?.firstName ?? "")
                return cell
                
            case .secondName:
                let cell = tableView.dequeueReusableCell(withIdentifier: "fieldCell", for: indexPath) as! FieldEditCell
                cell.setupCell(name: "Фамилия", field: profileInfo?.lastName ?? "")
                return cell
                
            case .address:
                let cell = tableView.dequeueReusableCell(withIdentifier: "fieldCell", for: indexPath) as! FieldEditCell
                cell.setupCell(name: "Адрес", field: "profileInfo?.address[0]")
                return cell
                
            case .numberPhone:
                let cell = tableView.dequeueReusableCell(withIdentifier: "fieldCell", for: indexPath) as! FieldEditCell
                cell.setupCell(name: "Номер телефона", field: profileInfo?.phone ?? "")
                return cell
                
            case .email:
                let cell = tableView.dequeueReusableCell(withIdentifier: "fieldCell", for: indexPath) as! FieldEditCell
                cell.setupCell(name: "Email", field: profileInfo?.email ?? "")
                return cell
                
            case .shopMode:
                let cell = tableView.dequeueReusableCell(withIdentifier: "boxCell", for: indexPath) as! CheckboxEditCell
                cell.setupCell(name: "Режим магазина", firstName: "Магазин", secondName: "Частная торговля")
                isShopMode = cell.isFirstSelected
                cell.updateView = {
                    self.tableView.reloadData()
                }
                return cell
                
            case .none:
                return UITableViewCell()
                
            }
        } else {
            let row = RowTwoKind(rawValue: indexPath.row)
            switch row {
            case .shopName:
                let cell = tableView.dequeueReusableCell(withIdentifier: "fieldCell", for: indexPath) as! FieldEditCell
                cell.setupCell(name: "Название магазина", field: profileInfo?.storeName ?? "")
                return cell
                
            case .colorName:
                let cell = tableView.dequeueReusableCell(withIdentifier: "boxCell", for: indexPath) as! CheckboxEditCell
                cell.setupCell(name: "Цвет названия", firstName: "Светлый", secondName: "Темный")
                return cell
                
            case .shopImage:
                let cell = tableView.dequeueReusableCell(withIdentifier: "backCell", for: indexPath) as! BackImageCell
                cell.setupCell(name: "Фон магазина", image: profileInfo?.banner)
                return cell
                
            case .none:
                return UITableViewCell()
                
            }
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

extension ProfileEditViewController: ProfileEditViewControllerProtocol {
   
    func setProfileInfo(data: StoreInfoResult) {
        DispatchQueue.main.async { [weak self] in
            self?.profileInfo = data
            self?.tableView.reloadData()
        }
    }
}
