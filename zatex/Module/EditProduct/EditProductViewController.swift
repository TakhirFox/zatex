//
//  EditProductEditProductViewController.swift
//  zatex
//
//  Created by winzero on 22/01/2024.
//  Copyright © 2024 zakirovweb. All rights reserved.
//

import UIKit

protocol EditProductViewControllerProtocol: AnyObject {
    var presenter: EditProductPresenterProtocol? { get set }
    
    func setProductInfo(data: ProductResult)
    func setCategories(data: [CategoryResult])
    func setCurrencies(data: [CurrencyResult])
//    func stopImageSpinner()
    func showSuccessUpload()
    
    func showToastProductError(text: String)
    func showToastCategoryError(text: String)
    func showToastCurrencyError(text: String)
    func showToastPublishError(text: String)
    func showToastImageError(text: String)
    func showToastUpdateProductError(text: String)
    
    func showEmptyProductName()
    func showEmptyDescription()
    func showEmptyCost()
    func showEmptyCategory()
    func showEmptyCurrency()
}

class EditProductViewController: BaseViewController {
    
    enum RowKind: Int {
        case productName, category, description, cost, currency, images, send
    }
    
    var presenter: EditProductPresenterProtocol?
    var productId: Int?
    
    private var productPost = ProductEntity()
    private var productInfo: ProductResult?
    private var categories: [CategoryResult] = []
    private var currencies: [CurrencyResult] = []
    private var pickerTextFieldTag: Int?
    private var selectedCurrency: Int?
    private var selectedCategory: Int?

    private let successView = SuccessProductView()
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let pickerView = UIPickerView()
    private let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImagePicker()
        setupPickerView()
        setupTableView()
        setupSubviews()
        setupConstraints()
        setSuccessView()
        
        presenter?.getCategories()
        presenter?.getCurrencies()
        presenter?.getProductInfo(id: productId!)
    }
    
    func setupSubviews() {
        view.addSubview(tableView)
        view.addSubview(successView)
    }
    
    private func setupConstraints() {
        successView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        title = "Редактирование"
        
        tableView.register(CreateProductFieldCell.self, forCellReuseIdentifier: "nameFieldCell")
        tableView.register(CreateProductFieldCell.self, forCellReuseIdentifier: "categoryFieldCell")
        tableView.register(CreateProductFieldCell.self, forCellReuseIdentifier: "costFieldCell")
        tableView.register(CreateProductFieldCell.self, forCellReuseIdentifier: "currencyFieldCell")
        tableView.register(CreateProductDesctiptionCell.self, forCellReuseIdentifier: "descriptionCell")
        tableView.register(CreateProductImagesCell.self, forCellReuseIdentifier: "imagesCell")
        tableView.register(CreateProductButtonCell.self, forCellReuseIdentifier: "buttonCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
    }
    
    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    private func setSuccessView() {
        successView.isHidden = true
        successView.newProductButton.addTarget(self, action: #selector(goToBack), for: .touchUpInside)
    }
}

extension EditProductViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 7
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let row = RowKind(rawValue: indexPath.row)
        switch row {
        case .productName:
            let cell = tableView.dequeueReusableCell(withIdentifier: "nameFieldCell", for: indexPath) as! CreateProductFieldCell
            cell.setupCell(name: "Название")
            cell.textField.addTarget(self, action: #selector(productNameDidChange(_:)), for: .editingChanged)
            cell.textField.delegate = self
            return cell
            
        case .category:
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryFieldCell", for: indexPath) as! CreateProductFieldCell
            cell.setupCell(name: "Категория")
            
            if selectedCategory != nil {
                let categoryName = categories[selectedCategory!].name
                
                cell.textField.text = categoryName
            }
            
            cell.textField.tag = 5
            cell.textField.inputView = pickerView
            cell.textField.delegate = self
            return cell
            
        case .description:
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as! CreateProductDesctiptionCell
            cell.setupCell(name: "Опишите товар")
            cell.textView.delegate = self
            return cell
            
        case .cost:
            let cell = tableView.dequeueReusableCell(withIdentifier: "costFieldCell", for: indexPath) as! CreateProductFieldCell
            cell.setupCell(name: "Укажите цену")
            cell.textField.addTarget(self, action: #selector(costDidChange(_:)), for: .editingChanged)
            cell.textField.delegate = self
            cell.textField.keyboardType = .numberPad
            return cell
            
        case .currency:
            let cell = tableView.dequeueReusableCell(withIdentifier: "currencyFieldCell", for: indexPath) as! CreateProductFieldCell
            cell.setupCell(name: "Валюта")
            
            if selectedCurrency != nil {
                let name = currencies[selectedCurrency!].name
                let symbol = currencies[selectedCurrency!].symbol
                
                cell.textField.text = "\(name) (\(symbol))"
            }
            
            cell.textField.tag = 6
            cell.textField.inputView = pickerView
            cell.textField.delegate = self
            return cell
            
        case .images:
            let cell = tableView.dequeueReusableCell(withIdentifier: "imagesCell", for: indexPath) as! CreateProductImagesCell
            cell.setupCell(images: productPost.images)
            
            cell.removeImageHandler = { [weak self] index in
                self?.productPost.images.remove(at: index)
                self?.presenter?.removeImage(index: index)
            }
            
            cell.reloadCell()
            cell.plusButton.addTarget(self, action: #selector(showImagePicker), for: .touchUpInside)
            return cell
            
        case .send:
            let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! CreateProductButtonCell
            cell.setupCell(name: "Разместить")
            cell.sendButton.addTarget(self, action: #selector(publishProduct), for: .touchUpInside)
            return cell
            
        case .none:
            return UITableViewCell()
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        
        let headerView = CreateProductHeaderCell()
        headerView.setupCell("Новое объявление")
        
        return headerView
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return 50
    }
}

extension EditProductViewController: UITextViewDelegate, UITextFieldDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text != nil {
            productPost.description = textView.text
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerTextFieldTag = textField.tag
    }
}

extension EditProductViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        switch pickerTextFieldTag {
        case 5:
            return categories.count
            
        case 6:
            return currencies.count
            
        default: return 0
        }
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        switch pickerTextFieldTag {
        case 5:
            let id = categories[row].id
            productPost.category = id
            
            return categories[row].name
            
        case 6:
            let name = currencies[row].name
            let symbol = currencies[row].symbol
            
            productPost.currencySymbol = symbol
            
            return "\(name) (\(symbol))"
            
        default: return ""
        }
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        switch pickerTextFieldTag {
        case 5:
            selectedCategory = row
            tableView.reloadRows(at: [IndexPath(item: 1, section: 0)], with: .automatic)
            
        case 6:
            selectedCurrency = row
            tableView.reloadRows(at: [IndexPath(item: 4, section: 0)], with: .automatic)
            
        default: break
        }
    }
}

extension EditProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        
        let imageEntity = ProductEntity.Image(image: image)
        
        productPost.images.insert(imageEntity, at: 0)
        presenter?.uploadImage(image: image)
        tableView.reloadData()
        imagePicker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

extension EditProductViewController {
    
    @objc func productNameDidChange(_ textField: UITextField) {
        if textField.text != nil {
            productPost.productName = textField.text
        }
    }
    
    @objc func costDidChange(_ textField: UITextField) {
        if textField.text != nil {
            productPost.cost = textField.text
        }
    }
    
    @objc func publishProduct() {
        for index in 0..<4 {
            if index == 2 {
                guard let cell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? CreateProductDesctiptionCell else { return }
                cell.textView.layer.borderColor = Palette.BorderField.primary.cgColor
            } else {
                setStandartColorToTextField(index: index)
            }
        }
        
        showLoader(enable: true)
        presenter?.checkTextFieldEmpty(data: productPost)
    }
    
    private func setStandartColorToTextField(index: Int) {
        guard let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? CreateProductFieldCell else { return }
        cell.textField.layer.borderColor = Palette.BorderField.primary.cgColor
    }
    
    @objc func showImagePicker() { // TODO: Refactoring
        let alert = UIAlertController(title: "Загрузить изображение", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Камера", style: .default) { _ in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let libraryAction = UIAlertAction(title: "Галерея", style: .default) { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func goToBack() {
        presenter?.goToBack()
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

extension EditProductViewController: EditProductViewControllerProtocol {
    
    func setProductInfo(data: ProductResult) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.productInfo = data
            self.tableView.reloadData()
        }
    }
   
    func setCategories(data: [CategoryResult]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.categories = data
            self.tableView.reloadData()
        }
    }
    
    func setCurrencies(data: [CurrencyResult]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.currencies = data
            self.tableView.reloadData()
        }
    }
    
//    func stopImageSpinner() {
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else { return }
//            productPost.images[0].isLoaded = true
//            self.tableView.reloadData()
//        }
//    }
    
    func showSuccessUpload() {
        successView.isHidden = false
        showLoader(enable: false)
    }
    
    func showToastProductError(text: String) {
        toastAnimation(text: text) { [weak self] in
            guard let self = self else { return }
            self.presenter?.getProductInfo(id: self.productId!)
        }
    }
    
    func showToastCategoryError(text: String) {
        toastAnimation(text: text) { [weak self] in
            self?.presenter?.getCategories()
        }
    }
    
    func showToastCurrencyError(text: String) {
        toastAnimation(text: text) { [weak self] in
            self?.presenter?.getCurrencies()
        }
    }
    
    func showToastPublishError(text: String) {
        toastAnimation(text: text) { [weak self] in
            self?.presenter?.publishProduct(data: self!.productPost)
            self?.showLoader(enable: true)
        }
        
        showLoader(enable: false)
    }
    
    func showToastImageError(text: String) {
        toastAnimation(text: text) {}
        
        showLoader(enable: false)
    }
    
    func showToastUpdateProductError(text: String) {
        toastAnimation(text: text) { [weak self] in
//            self?.presenter?.getCurrencies() // TODO: update 
        }
    }
    
    func showEmptyProductName() {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CreateProductFieldCell else { return }
        cell.textField.layer.borderColor = Palette.BorderField.wrong.cgColor
        showLoader(enable: false)
    }
    
    func showEmptyDescription() {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? CreateProductDesctiptionCell else { return }
        cell.textView.layer.borderColor = Palette.BorderField.wrong.cgColor
        showLoader(enable: false)
    }
    
    func showEmptyCost() {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? CreateProductFieldCell else { return }
        cell.textField.layer.borderColor = Palette.BorderField.wrong.cgColor
        showLoader(enable: false)
    }
    
    func showEmptyCategory() {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? CreateProductFieldCell else { return }
        cell.textField.layer.borderColor = Palette.BorderField.wrong.cgColor
        showLoader(enable: false)
    }
    
    func showEmptyCurrency() {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as? CreateProductFieldCell else { return }
        cell.textField.layer.borderColor = Palette.BorderField.wrong.cgColor
        showLoader(enable: false)
    }
}
