//
//  AdminPanelAdminPanelViewController.swift
//  zatex
//
//  Created by winzero on 14/01/2024.
//  Copyright © 2024 zakirovweb. All rights reserved.
//

import UIKit
import Kingfisher

protocol AdminPanelViewControllerProtocol: AnyObject {
    
    var presenter: AdminPanelPresenterProtocol? { get set }
    
    func setMainEntity()
    func showUserList(data: [AdminPanelEntry])
}

struct AdminPanelEntry {
    var id: Int
    var title: String
    var subTitle: String
    var imageUrl: String
    var type: AdminPanelPresenter.AdminPanelType
}

class AdminPanelViewController: BaseViewController {
    
    var presenter: AdminPanelPresenterProtocol?
    var adminPanelType: AdminPanelPresenter.AdminPanelType = .main
    var entity: [AdminPanelEntry] = []
    var currentPage = 1
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch adminPanelType {
        case .main:
            presenter?.getMainData()
            
        case .userList:
            presenter?.getUserList(page: currentPage)
            
        case .stats:
            break
            
        case .userDetail:
            break
        }
        
        setupSubviews()
        setupConstraints()
        setupTableView()
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
        title = adminPanelType.title
        
        tableView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
    }
    
}

extension AdminPanelViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return entity.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.backgroundColor = .clear
        cell.textLabel?.text = entity[indexPath.row].title
        cell.detailTextLabel?.text = entity[indexPath.row].subTitle
        
        let imageUrl = entity[indexPath.row].imageUrl
        let url = (imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        let urlString = URL(string: url)
        cell.imageView?.kf.setImage(with: urlString)
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        switch entity[indexPath.row].type {
        case .main: 
            break
            
        case .stats: 
            presenter?.goToStats()
            
        case .userList:
            presenter?.goToUserList()
            
        case .userDetail: 
            break
            
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch adminPanelType {
        case .userList:
            if indexPath.row == entity.count - 1 {
                presenter?.getUserList(page: currentPage)
            }
            
        default:
            break
        }
    }
}

extension AdminPanelViewController: AdminPanelViewControllerProtocol {
    
    func setMainEntity() {
        entity = [
            AdminPanelEntry(
                id: 0,
                title: "Список пользователей",
                subTitle: "",
                imageUrl: "",
                type: .userList
            ),
            AdminPanelEntry(
                id: 1,
                title: "Статистика",
                subTitle: "",
                imageUrl: "",
                type: .stats
            )
        ]
    }
    
    func showUserList(data: [AdminPanelEntry]) {
        switch adminPanelType {
        case .userList:
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                guard !data.isEmpty else { return }
                self.entity += data
                self.currentPage += 1
                self.tableView.reloadData()
            }
            
        default: 
            break
        }
    }
}
