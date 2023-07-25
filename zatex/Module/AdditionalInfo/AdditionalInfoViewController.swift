//
//  AdditionalInfoAdditionalInfoViewController.swift
//  zatex
//
//  Created by winzero on 17/07/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol AdditionalInfoViewControllerProtocol: AnyObject {
    var presenter: AdditionalInfoPresenterProtocol? { get set }
    
    func showToastError(text: String)
}

class AdditionalInfoViewController: BaseViewController {
    
    enum RowKind: Int {
        case avatar, firstname, lastname, phone, shopMode
    }
    
    enum RowTwoKind: Int {
        case shopName, address, shopImage
    }
    
    var presenter: AdditionalInfoPresenterProtocol?
    
    var additionalInfo = AdditionalInfoEntity()
    
    var isBannerUpdate = false
    var isShop = false
    
    let buttonView = AddInfoButtonView()
    let tableView = UITableView(frame: .zero, style: .grouped)
    let imagePicker = UIImagePickerController()
    
    private let changeAvatarGesture = UITapGestureRecognizer()
    private let changeBannerGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSubviews()
        setupConstraints()
        setupButtonView()
        setupImagePicker()
    }
    
    func setupSubviews() {
        view.addSubview(tableView)
        view.addSubview(buttonView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        buttonView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(24)
        }
    }
    
    func setupTableView() {
        title = "Дополнительная информация"
        
        tableView.register(AvatarAddInfoCell.self, forCellReuseIdentifier: "avatarImageCell")
        tableView.register(FieldAddInfoCell.self, forCellReuseIdentifier: "firstnameFieldCell")
        tableView.register(FieldAddInfoCell.self, forCellReuseIdentifier: "lastnameFieldCell")
        tableView.register(FieldAddInfoCell.self, forCellReuseIdentifier: "phoneFieldCell")
        tableView.register(AddInfoButtonCell.self, forCellReuseIdentifier: "finishSignUpButtonCell")
        tableView.register(CheckboxAddInfoCell.self, forCellReuseIdentifier: "storeModeBoxCell")
        tableView.register(FieldAddInfoCell.self, forCellReuseIdentifier: "storeNameFieldCell")
        tableView.register(FieldAddInfoCell.self, forCellReuseIdentifier: "addressFieldCell")
        tableView.register(BackImageAddInfoCell.self, forCellReuseIdentifier: "backCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    private func setupButtonView() {
        buttonView.setupView(sendName: "Завершить", skipName: "Пропустить")
        buttonView.sendButton.addTarget(self, action: #selector(finishSignUpAction), for: .touchUpInside)
        buttonView.skipButton.addTarget(self, action: #selector(skipSignUpAction), for: .touchUpInside)
    }
    
    private func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
}

extension AdditionalInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isShop ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let row = RowKind(rawValue: indexPath.row)
            switch row {
            case .avatar:
                let cell = tableView.dequeueReusableCell(withIdentifier: "avatarImageCell", for: indexPath) as! AvatarAddInfoCell
                cell.setupCell(image: additionalInfo.avatar)
                cell.avatarImage.addGestureRecognizer(changeAvatarGesture)
                changeAvatarGesture.addTarget(self, action: #selector(showAvatarDialog))
                return cell
                
            case .firstname:
                let cell = tableView.dequeueReusableCell(withIdentifier: "firstnameFieldCell", for: indexPath) as! FieldAddInfoCell
                cell.textField.addTarget(self, action: #selector(firstnameDidChange(_:)), for: .editingChanged)
                cell.setupCell(name: "Имя")
                cell.textField.delegate = self
                return cell
                
            case .lastname:
                let cell = tableView.dequeueReusableCell(withIdentifier: "lastnameFieldCell", for: indexPath) as! FieldAddInfoCell
                cell.textField.addTarget(self, action: #selector(lastnameDidChange(_:)), for: .editingChanged)
                cell.setupCell(name: "Фамилия")
                cell.textField.delegate = self
                return cell
                
            case .phone:
                let cell = tableView.dequeueReusableCell(withIdentifier: "phoneFieldCell", for: indexPath) as! FieldAddInfoCell
                cell.textField.addTarget(self, action: #selector(phoneDidChange(_:)), for: .editingChanged)
                cell.setupCell(name: "Телефон")
                cell.textField.delegate = self
                return cell
                
            case .shopMode:
                let cell = tableView.dequeueReusableCell(withIdentifier: "storeModeBoxCell", for: indexPath) as! CheckboxAddInfoCell
                cell.setupCell(
                    name: "Включить режим магазина?",
                    firstName: "Включить",
                    isShop: isShop
                )
                
                self.additionalInfo.isShop = cell.firstRatioButton.isSelected
                
                cell.updateView = {
                    self.isShop = cell.firstRatioButton.isSelected
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "storeNameFieldCell", for: indexPath) as! FieldAddInfoCell
                cell.setupCell(name: "Название магазина")
                cell.textField.addTarget(self, action: #selector(storeNameDidChange(_:)), for: .editingChanged)
                cell.textField.delegate = self
                return cell
                
            case .address:
                let cell = tableView.dequeueReusableCell(withIdentifier: "addressFieldCell", for: indexPath) as! FieldAddInfoCell
                cell.textField.addTarget(self, action: #selector(addressDidChange(_:)), for: .editingChanged)
                cell.setupCell(name: "Адрес")
                cell.textField.delegate = self
                return cell
                
            case .shopImage:
                let cell = tableView.dequeueReusableCell(withIdentifier: "backCell", for: indexPath) as! BackImageAddInfoCell
                cell.setupCell(name: "Фон магазина", image: additionalInfo.banner)
                cell.avatarImage.addGestureRecognizer(changeBannerGesture)
                changeBannerGesture.addTarget(self, action: #selector(showBannerDialog))
                return cell
                
            case .none:
                return UITableViewCell()
                
            }
        }
    }
}

extension AdditionalInfoViewController: UITextFieldDelegate {}

extension AdditionalInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        
        if isBannerUpdate {
            additionalInfo.banner = image
        } else {
            additionalInfo.avatar = image
        }
        
        tableView.reloadData()
        imagePicker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

extension AdditionalInfoViewController {
    
    @objc func firstnameDidChange(_ textField: UITextField) {
        if textField.text != nil {
            additionalInfo.firstName = textField.text
        }
    }
    
    @objc func lastnameDidChange(_ textField: UITextField) {
        if textField.text != nil {
            additionalInfo.lastName = textField.text
        }
    }
    
    @objc func phoneDidChange(_ textField: UITextField) {
        if textField.text != nil {
            additionalInfo.phone = textField.text
        }
    }
    
    @objc func storeNameDidChange(_ textField: UITextField) {
        if textField.text != nil {
            additionalInfo.storeName = textField.text
        }
    }
    
    @objc func addressDidChange(_ textField: UITextField) {
        if textField.text != nil {
            additionalInfo.address = textField.text
        }
    }
    
    @objc func finishSignUpAction() {
        presenter?.saveAdditionalInfo(entity: additionalInfo)
    }
    
    @objc func skipSignUpAction() {
        presenter?.signUpSuccess()
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
}

extension AdditionalInfoViewController: AdditionalInfoViewControllerProtocol {
    
    func showToastError(text: String) {
        toastAnimation(text: text) { [weak self] in
            self?.presenter?.saveAdditionalInfo(entity: self!.additionalInfo)
        }
    }
}
