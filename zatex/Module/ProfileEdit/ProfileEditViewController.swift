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
    func showToastGetProfileError(text: String)
    func showToastUpdateProfileError(text: String)
    func showToastImageError(text: String)
}

class ProfileEditViewController: BaseViewController {
    
    enum RowKind: Int {
        case avatar, firstName, secondName, address, numberPhone, email, shopMode
    }
    
    enum RowTwoKind: Int {
        case shopName, shopImage
    }
    
    var presenter: ProfileEditPresenterProtocol?
    
    var sessionProvider: SessionProvider?
    var profileInfo: StoreInfoResult?
    var updateInfo = UpdateInfoEntity()
    
    var isBannerUpdate = false
    var isShop = false
    
    let successView = SuccessUpdateProfileView()
    let buttonView = ProfileEditButtonView()
    let tableView = UITableView(frame: .zero, style: .grouped)
    let imagePicker = UIImagePickerController()
    
    private let changeAvatarGesture = UITapGestureRecognizer()
    private let changeBannerGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFirstParty()
        setupTableView()
        setupSubviews()
        setupConstraints()
        setupSuccessView()
        setupButtonView()
        setupImagePicker()
    }
    
    private func setupFirstParty() {
        if let userId = sessionProvider?.getSession()?.userId,
            let id = Int(userId) {
            presenter?.getProfileInfo(id: id)
        }
        
        tableView.isHidden = true
        buttonView.isHidden = true
        loaderView.isHidden = false
        loaderView.play()
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        view.addSubview(buttonView)
        view.addSubview(successView)
    }
    
    private func setupConstraints() {
        successView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        buttonView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(24)
        }
    }
    
    private func setupTableView() {
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
    
    private func setupButtonView() {
        buttonView.setupView(name: "Сохранить")
        buttonView.sendButton.addTarget(self, action: #selector(updateInformation), for: .touchUpInside)
    }
    
    private func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
}

extension ProfileEditViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return isShop ? 2 : 1
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        if section == 0 {
            return 7
        } else {
            return 3
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let row = RowKind(rawValue: indexPath.row)
            switch row {
            case .avatar:
                let cell = tableView.dequeueReusableCell(withIdentifier: "avatarCell", for: indexPath) as! AvatarEditCell
                cell.setupCell(image: profileInfo, local: updateInfo.localAvatar)
                cell.avatarImage.addGestureRecognizer(changeAvatarGesture)
                changeAvatarGesture.addTarget(self, action: #selector(showAvatarDialog))
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
                var street = ""
                
                switch profileInfo?.address {
                case .address(let address):
                    street = address.street1 ?? ""
                    
                case .empty, nil:
                    break
                }
                
                cell.setupCell(name: "Адрес", field: street)
                
                cell.textField.isEnabled = false
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
                cell.setupCell(
                    name: "Режим магазина",
                    firstName: "Магазин",
                    secondName: "Частная торговля",
                    isShop: isShop
                )
                
                self.updateInfo.isShop = cell.isFirstSelected
                
                cell.updateView = {
                    self.isShop = cell.isFirstSelected
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "storeNaMeFieldCell", for: indexPath) as! FieldEditCell
                cell.setupCell(name: "Название магазина", field: profileInfo?.storeName ?? "")
                cell.textField.addTarget(self, action: #selector(storeNameDidChange(_:)), for: .editingChanged)
                cell.textField.delegate = self
                return cell
                
            case .shopImage:
                let cell = tableView.dequeueReusableCell(withIdentifier: "backCell", for: indexPath) as! BackImageCell
                cell.setupCell(name: "Фон магазина", image: profileInfo?.banner, local: updateInfo.localBanner)
                cell.avatarImage.addGestureRecognizer(changeBannerGesture)
                changeBannerGesture.addTarget(self, action: #selector(showBannerDialog))
                return cell
                
            case .none:
                return UITableViewCell()
                
            }
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let headerView = HeaderCell()
        
        if section == 0 {
            headerView.setupCell("Основная информация")
        } else if section == 1 {
            headerView.setupCell("Информация магазина")
        }
        
        return headerView
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return 50
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard indexPath.section == 0 && indexPath.row == 3 else { return }
        
        presenter?.goToMap(saveAddressHandler: { [weak self] address in
            DispatchQueue.main.async { [weak self] in
                guard let cell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? FieldEditCell else { return }
                cell.textField.text = address
                
                self?.updateInfo.address = address
            }
        })
    }
}

extension ProfileEditViewController: UITextFieldDelegate {}

extension ProfileEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        
        if isBannerUpdate {
            updateInfo.localBanner = image
        } else {
            updateInfo.localAvatar = image
        }
        
        tableView.reloadData()
        imagePicker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

extension ProfileEditViewController {
    
    @objc func updateInformation() {
        presenter?.updateProfileInfo(data: updateInfo)
        
        showLoader(enable: true)
    }
    
    @objc func firstNameDidChange(_ textField: UITextField) {
        if textField.text != nil {
            updateInfo.firstName = textField.text
        }
    }
    
    @objc func lastNameDidChange(_ textField: UITextField) {
        if textField.text != nil {
            updateInfo.lastName = textField.text
        }
    }
    
    @objc func numberPhoneDidChange(_ textField: UITextField) {
        if textField.text != nil {
            updateInfo.phone = textField.text
        }
    }
    
    @objc func emailDidChange(_ textField: UITextField) {
        if textField.text != nil {
            updateInfo.email = textField.text
        }
    }
    
    @objc func storeNameDidChange(_ textField: UITextField) {
        if textField.text != nil {
            updateInfo.storeName = textField.text
        }
    }
    
    @objc func closeView() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func showAvatarDialog() { // TODO: Пока так, потом будем объединять эти методы
        let alertController = UIAlertController()
        
        let galleryButton = UIAlertAction(
            title: "Открыть галерею",
            style: .default
        ) { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let cameraButton = UIAlertAction(
            title: "Сделать фотографию",
            style: .default
        ) { _ in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let cancelButton = UIAlertAction(title: "Отмена", style: .destructive)
        
        alertController.addAction(galleryButton)
        alertController.addAction(cameraButton)
        alertController.addAction(cancelButton)
        
        isBannerUpdate = false
        
        self.present(alertController, animated: true)
    }
    
    @objc func showBannerDialog() { // TODO: Пока так, потом будем объединять эти методы
        let alertController = UIAlertController()
        
        let galleryButton = UIAlertAction(
            title: "Открыть галерею",
            style: .default
        ) { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let cameraButton = UIAlertAction(
            title: "Сделать фотографию",
            style: .default
        ) { _ in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let cancelButton = UIAlertAction(title: "Отмена", style: .destructive)
        
        alertController.addAction(galleryButton)
        alertController.addAction(cameraButton)
        alertController.addAction(cancelButton)
        
        isBannerUpdate = true
        
        self.present(alertController, animated: true)
    }
    
    private func showLoader(enable: Bool) {
        if enable {
            loaderView.play()
        } else {
            loaderView.stop()
        }
        
        loaderView.isHidden = !enable
        tableView.alpha = enable ? 0.5 : 1
        buttonView.alpha = enable ? 0.5 : 1
        tableView.isUserInteractionEnabled = !enable
        buttonView.isUserInteractionEnabled = !enable
    }
}

extension ProfileEditViewController: ProfileEditViewControllerProtocol {
   
    func setProfileInfo(data: StoreInfoResult) {
        DispatchQueue.main.async { [weak self] in
            self?.profileInfo = data
            self?.isShop = data.isShop ?? false
            self?.tableView.isHidden = false
            self?.buttonView.isHidden = false
            self?.loaderView.isHidden = true
            self?.loaderView.stop()
            self?.tableView.reloadData()
        }
    }
    
    func successUpdateInfo() {
        successView.isHidden = false
        
        showLoader(enable: false)
    }
    
    func showToastGetProfileError(text: String) {
        toastAnimation(text: text) { [weak self] in
            if let userId = self?.sessionProvider?.getSession()?.userId,
                let id = Int(userId) {
                self?.presenter?.getProfileInfo(id: id)
            }
            
            self?.showLoader(enable: true)
        }
        
        showLoader(enable: false)
    }
    
    func showToastUpdateProfileError(text: String) {
        toastAnimation(text: text) { [weak self] in
            self?.presenter?.updateProfileInfo(data: self?.updateInfo ?? UpdateInfoEntity())
            self?.showLoader(enable: true)
        }
        
        showLoader(enable: false)
    }
    
    func showToastImageError(text: String) {
        toastAnimation(text: text) {}
        showLoader(enable: false)
    }
}
