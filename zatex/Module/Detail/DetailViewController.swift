//
//  DetailDetailViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 03/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    var presenter: DetailPresenterProtocol? { get set }

}

class DetailViewController: BaseViewController {
    
    enum RowKind: Int {
        case images, productInfo, mapShop, buttons, descriptions, author, similarProduct
    }
    
    var presenter: DetailPresenterProtocol?
    
    let tableView = UITableView()
    let headerView = ShopHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.setupCell(name: "")
        
        setupTableView()
        
        setupSubviews()
        setupConstraints()
    }
    
    func setupTableView() {
        title = ""
        
        tableView.register(ImagesProductCell.self, forCellReuseIdentifier: "imagesCell")
        tableView.register(InfoProductCell.self, forCellReuseIdentifier: "infoCell")
        tableView.register(MapProductCell.self, forCellReuseIdentifier: "mapCell")
        tableView.register(ContactProductCell.self, forCellReuseIdentifier: "buttonsCell")
        tableView.register(DescriptionProductCell.self, forCellReuseIdentifier: "descCell")
        tableView.register(AuthorProdCell.self, forCellReuseIdentifier: "authorCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    func setupSubviews() {
        view.addSubview(tableView)
        view.addSubview(headerView)
    }
    
    func setupConstraints() {
        tableView.contentInset = UIEdgeInsets(top: 280, left: 0, bottom: 0, right: 0)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rows = RowKind(rawValue: indexPath.row)
        switch rows {
        case .images:
            let cell = tableView.dequeueReusableCell(withIdentifier: "imagesCell", for: indexPath) as! ImagesProductCell
            cell.setupCell(name: "ИЗМЕНИТЬ МОДЕЛЬ")
            return cell
        case .productInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoProductCell
            cell.setupCell(name: "ИЗМЕНИТЬ МОДЕЛЬ")
            return cell
        case .mapShop:
            let cell = tableView.dequeueReusableCell(withIdentifier: "mapCell", for: indexPath) as! MapProductCell
            cell.setupCell(name: "ИЗМЕНИТЬ МОДЕЛЬ")
            return cell
        case .buttons:
            let cell = tableView.dequeueReusableCell(withIdentifier: "buttonsCell", for: indexPath) as! ContactProductCell
            cell.setupCell(name: "ИЗМЕНИТЬ МОДЕЛЬ")
            return cell
        case .descriptions:
            let cell = tableView.dequeueReusableCell(withIdentifier: "descCell", for: indexPath) as! DescriptionProductCell
            cell.setupCell(name: "ИЗМЕНИТЬ МОДЕЛЬ")
            return cell
        case .author:
            let cell = tableView.dequeueReusableCell(withIdentifier: "authorCell", for: indexPath) as! AuthorProdCell
            cell.setupCell(name: "ИЗМЕНИТЬ МОДЕЛЬ")
            return cell
        case .similarProduct:
            return UITableViewCell()
        case .none:
            return UITableViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = -scrollView.contentOffset.y
        let maxHeight = max(offsetY, 100)
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: maxHeight)
        
        let pointInfo = -(-scrollView.contentOffset.y - scrollView.contentInset.top) / 1.3
        let centerInfo = (view.frame.width / 2) - (headerView.backView.frame.width / 2)
        let fromLeadingToCenterInfo = min(max(pointInfo, 16), centerInfo)
        
        headerView.backView.snp.updateConstraints { make in
            make.leading.equalToSuperview().inset(fromLeadingToCenterInfo)
        }
        
    }
    
}

extension DetailViewController: DetailViewControllerProtocol {
   
}
