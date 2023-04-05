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
    
}

class CreateProductViewController: BaseViewController {
    
    enum RowKind: Int {
        case productName, category, description, cost
    }
    
    var presenter: CreateProductPresenterProtocol?
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
}

extension CreateProductViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 4
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
            return cell
            
        case .category:
            let cell = tableView.dequeueReusableCell(withIdentifier: "fieldCell", for: indexPath) as! CreateProductFieldCell
            cell.setupCell(name: "Категория")
            return cell
            
        case .description:
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as! CreateProductDesctiptionCell
            cell.setupCell(name: "Опишите товар")
            return cell
            
        case .cost:
            let cell = tableView.dequeueReusableCell(withIdentifier: "fieldCell", for: indexPath) as! CreateProductFieldCell
            cell.setupCell(name: "Укажите цену")
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

extension CreateProductViewController: CreateProductViewControllerProtocol {
    
}
