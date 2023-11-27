//
//  GeneralSettingsGeneralSettingsViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit
import Lottie

protocol GeneralSettingsViewControllerProtocol: AnyObject {
    var presenter: GeneralSettingsPresenterProtocol? { get set }
    
    func showSuccess()
    func showToastError(text: String)
}

class GeneralSettingsViewController: BaseViewController {
    
    enum RowKind: Int {
        case editProfile, changeTheme, changePush, logout, delete
    }
    
    var presenter: GeneralSettingsPresenterProtocol?
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let spinnerView = LottieAnimationView(name: "loader")
    
    var settingsModel: [SettingsModel] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setupTableView()
        
        setupSubviews()
        setupConstraints()
        settingSpinner()
    }
    
    private func settingSpinner() {
        spinnerView.contentMode = .scaleAspectFill
        spinnerView.loopMode = .loop
        spinnerView.animationSpeed = 2
        
        showLoader(enable: false)
    }
    
    func setData() {
        settingsModel = [
            SettingsModel(
                title: "Редактировать профиль",
                subTitle: "Измените свои данные аккаунта",
                icon: "ProfileIcon",
                rightIcon: "NextIcon"
            ),
            SettingsModel(
                title: "Изменить тему",
                subTitle: "Выбирайте светлую, либо темную тему",
                icon: "ThemeIcon",
                rightIcon: nil
            ),
            SettingsModel(
                title: "Включить уведомления",
                subTitle: "Включить, чтобы получать ништяки",
                icon: "PushIcon",
                rightIcon: nil
            ),
            SettingsModel(
                title: "Выйти из аккаунта",
                subTitle: "Выйти из аккаунта",
                icon: "LogoutIcon",
                rightIcon: "NextIcon"
            ),
            SettingsModel(
                title: "Удалить аккаунт",
                subTitle: "Вы можете безвозвратно удалить аккаунт",
                icon: "removeIcon",
                rightIcon: nil,
                isDestructive: true
            )
        ]
    }
    
    func setupSubviews() {
        view.addSubview(tableView)
        view.addSubview(spinnerView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        spinnerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
    }
    
    func setupTableView() {
        title = "Настройки"
        
        tableView.contentInset = .init(top: 24, left: 0, bottom: 0, right: 0)
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "cell")
        tableView.register(SettingsSwitchCell.self, forCellReuseIdentifier: "switchCell")
        tableView.register(SettingsThemeCell.self, forCellReuseIdentifier: "themeCell")
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "themeCell", for: indexPath) as! SettingsThemeCell
            cell.setupCell(
                settingsModel[indexPath.row],
                currentTheme: UserDefaults.standard.integer(forKey: "selectedStyle")
            )
            
            cell.setThemeAction = { [weak self] themeIndex in
                self?.setTheme(index: themeIndex)
            }
            return cell
            
        case .changePush:
            let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell", for: indexPath) as! SettingsSwitchCell
            let isNotificationsEnabled = UserDefaults.standard.bool(forKey: "notificationsEnabled")
            
            cell.setupCell(settingsModel[indexPath.row])
            cell.switchView.addTarget(self, action: #selector(changeNotifications), for: .valueChanged)
            cell.switchView.isOn = isNotificationsEnabled
            return cell
            
        case .logout:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingsCell
            cell.setupCell(settingsModel[indexPath.row])
            return cell
            
        case .delete:
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
            
        case .delete:
            showDeleteAccountAlert()
            
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

extension GeneralSettingsViewController {
    
    @objc func setTheme(index: Int) {
        switch index {
        case 0:
            UserDefaults.standard.set(0, forKey: "selectedStyle")
            if traitCollection.userInterfaceStyle == .dark {
                Appearance.shared.theme.value = .dark
            } else {
                Appearance.shared.theme.value = .light
            }
            
        case 1:
            UserDefaults.standard.set(1, forKey: "selectedStyle")
            Appearance.shared.theme.value = .light
            
        case 2:
            UserDefaults.standard.set(2, forKey: "selectedStyle")
            Appearance.shared.theme.value = .dark
            
        default:
            break
        }
    }
    
    @objc func changeNotifications(sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "notificationsEnabled")
        
        if sender.isOn {
            UIApplication.shared.registerForRemoteNotifications()
        } else {
            UIApplication.shared.unregisterForRemoteNotifications()
        }
    }
    
    private func showLoader(enable: Bool) {
        if enable {
            spinnerView.play()
        } else {
            spinnerView.stop()
        }
        
        spinnerView.isHidden = !enable
        tableView.alpha = enable ? 0.5 : 1
        tableView.isUserInteractionEnabled = !enable
    }
}

extension GeneralSettingsViewController {
    
    private func showDeleteAccountAlert() {
        let alertController = UIAlertController(title: "Вы действительно хотите удалить аккаунт?", message: "Это приведет к полному удалению аккаунта, со всей историей переписки, продажами, личной информацией? Запрос на удаление обрабатывается в течении 48 часов.", preferredStyle: .alert)
        
        let removeButton = UIAlertAction(
            title: "Удалить",
            style: .destructive
        ) { _ in
            self.showLoader(enable: true)
            self.presenter?.deleteAccount()
        }
        
        let cancelButton = UIAlertAction(title: "Отмена", style: .default)
        
        alertController.addAction(removeButton)
        alertController.addAction(cancelButton)
        
        self.present(alertController, animated: true)
    }
}

extension GeneralSettingsViewController: GeneralSettingsViewControllerProtocol {
    
    func showSuccess() {
        let alertController = UIAlertController(title: "Отправлено", message: "Запрос на удаление обрабатывается в течении 48 часов.", preferredStyle: .alert)
        
        let cancelButton = UIAlertAction(title: "Хорошо", style: .default) { [weak self] _ in
            self?.presenter?.logout()
            self?.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(cancelButton)
        
        self.present(alertController, animated: true)
        
        showLoader(enable: false)
    }
    
    func showToastError(text: String) {
        toastAnimation(text: text) { [weak self] in
            self?.showLoader(enable: true)
        }
        
        showLoader(enable: false)
    }
}
