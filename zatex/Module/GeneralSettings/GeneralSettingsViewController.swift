//
//  GeneralSettingsGeneralSettingsViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol GeneralSettingsViewControllerProtocol: AnyObject {
    var presenter: GeneralSettingsPresenterProtocol? { get set }
}

class GeneralSettingsViewController: BaseViewController {
    
    enum RowKind: Int {
        case editProfile, changeTheme, changePush, logout
    }
    
    var presenter: GeneralSettingsPresenterProtocol?
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    var settingsModel: [SettingsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setupTableView()
        
        setupSubviews()
        setupConstraints()
    }
    
    func setData() {
        settingsModel = [
            SettingsModel(title: "Редактировать профиль",
                          subTitle: "Измените свои данные аккаунта",
                          icon: "ProfileIcon",
                          rightIcon: "NextIcon"),
            SettingsModel(title: "Изменить тему",
                          subTitle: "Выбирайте светлую, либо темную тему",
                          icon: "ThemeIcon",
                          rightIcon: ""),
            SettingsModel(title: "Включить уведомление",
                          subTitle: "Включить, чтобы получать ништяки",
                          icon: "PushIcon",
                          rightIcon: ""),
            SettingsModel(title: "Выйти из аккаунта",
                          subTitle: "Выйти из аккаунта",
                          icon: "LogoutIcon",
                          rightIcon: "NextIcon")
        ]
    }
    
    func setupSubviews() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    func setupTableView() {
        title = "Настройки"
        
        tableView.contentInset = .init(top: 24, left: 0, bottom: 0, right: 0)
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "cell")
        tableView.register(SettingsSwitchCell.self, forCellReuseIdentifier: "switchCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
}

extension GeneralSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = RowKind(rawValue: indexPath.row)
        switch row {
        case .editProfile:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingsCell
            cell.setupCell(settingsModel[indexPath.row])
            return cell
        case .changeTheme:
            let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell", for: indexPath) as! SettingsSwitchCell
            cell.setupCell(settingsModel[indexPath.row])
            cell.switchView.addTarget(self, action: #selector(changeTheme), for: .valueChanged)
            cell.switchView.isOn = Appearance.shared.theme.value == .dark
            return cell
        case .changePush:
            let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell", for: indexPath) as! SettingsSwitchCell
            cell.setupCell(settingsModel[indexPath.row])
            cell.switchView.addTarget(self, action: #selector(changeNotifications), for: .valueChanged)
            return cell
        case .logout:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingsCell
            cell.setupCell(settingsModel[indexPath.row])
            return cell
        case .none:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = RowKind(rawValue: indexPath.row)
        switch row {
        case .editProfile:
            presenter?.goToProfileEdit()
        case .changeTheme:
            print("N0thing bro")
        case .changePush:
            print("N0thing bro")
        case .logout:
            presenter?.logout()
            navigationController?.popViewController(animated: true)
        case .none:
            print("N0thing bro")
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderCell()
        headerView.setupCell("Основные настройки")
        return headerView
    }
    
}

extension GeneralSettingsViewController: GeneralSettingsViewControllerProtocol {
    @objc func changeTheme() {
        if Appearance.shared.theme.value == .dark {
            UserDefaults.standard.set(0, forKey: "selectedStyle")
            Appearance.shared.theme.value = .light
        } else {
            UserDefaults.standard.set(1, forKey: "selectedStyle")
            Appearance.shared.theme.value = .dark
        }
    }
    
    @objc func changeNotifications() {
        print("assa")
    }
    
}
