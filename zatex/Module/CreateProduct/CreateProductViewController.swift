//
//  CreateProductCreateProductViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol CreateProductViewControllerProtocol: AnyObject {
    var presenter: CreateProductPresenterProtocol? { get set }
    
    func setCategories(data: [CategoryResult])
    func showSuccess()
}

class CreateProductViewController: BaseViewController {
    
    enum RowKind: Int {
        case productName, category, description, cost, send
    }
    
    var presenter: CreateProductPresenterProtocol?
    
    var productPost = ProductEntity()
    var categories: [CategoryResult] = []
    
    let tableView = UITableView()
    let pickerView = UIPickerView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.getCategories()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPickerView()
        setupTableView()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        title = "Добавить товар"
        
        tableView.register(CreateProductFieldCell.self, forCellReuseIdentifier: "fieldCell")
        tableView.register(CreateProductDesctiptionCell.self, forCellReuseIdentifier: "descriptionCell")
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
}

extension CreateProductViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 5
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let row = RowKind(rawValue: indexPath.row)
        switch row {
        case .productName:
            let cell = tableView.dequeueReusableCell(withIdentifier: "fieldCell", for: indexPath) as! CreateProductFieldCell
            cell.setupCell(name: "Название")
            cell.textField.addTarget(self, action: #selector(productNameDidChange(_:)), for: .editingChanged)
            cell.textField.delegate = self
            return cell
            
        case .category:
            let cell = tableView.dequeueReusableCell(withIdentifier: "fieldCell", for: indexPath) as! CreateProductFieldCell
            cell.setupCell(name: "Категория")
            
            if productPost.category != nil, let categoryName = categories[productPost.category ?? 0].name {
                cell.textField.text = categoryName
            }
            
            cell.textField.inputView = pickerView
            cell.textField.delegate = self
            return cell
            
        case .description:
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as! CreateProductDesctiptionCell
            cell.setupCell(name: "Опишите товар")
            cell.textView.delegate = self
            return cell
            
        case .cost:
            let cell = tableView.dequeueReusableCell(withIdentifier: "fieldCell", for: indexPath) as! CreateProductFieldCell
            cell.setupCell(name: "Укажите цену")
            cell.textField.addTarget(self, action: #selector(costDidChange(_:)), for: .editingChanged)
            cell.textField.delegate = self
            cell.textField.keyboardType = .numberPad
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

extension CreateProductViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text != nil {
            productPost.description = textView.text
        }
    }
    
}

extension CreateProductViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        return categories.count
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        return categories[row].name
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        productPost.category = row
        tableView.reloadRows(at: [IndexPath(item: 1, section: 0)], with: .automatic)
    }
    
}

extension CreateProductViewController {
    
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
        // TODO: Нужно сперва сделать проверку товара
        presenter?.publishProduct(data: productPost)
    }
}

extension CreateProductViewController: CreateProductViewControllerProtocol {
    
    func setCategories(data: [CategoryResult]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.categories = data
            self.tableView.reloadData()
        }
    }
    
    func showSuccess() {
        // TODO: Show success 
    }
}
