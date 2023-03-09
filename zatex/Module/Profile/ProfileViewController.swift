//
//  ProfileProfileViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }

}

class ProfileViewController: BaseViewController {
    
    enum RowKind: Int {
        case stats, myProducts
    }
    
    var presenter: ProfilePresenterProtocol?
    
    let tableView = UITableView()
    let headerView = ProfileHeaderView()
    let authorView = ProfileAuthorView()
    
    let loginButton: UIButton = {
        let view = UIButton()
        view.setTitle("Войти", for: .normal)
        view.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 15)
        view.addTarget(nil, action: #selector(showLoginView), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let asdasd = 0
        
        if asdasd == 1 {
            headerView.setupCell(name: "")
            authorView.setupCell(name: "")
            
            setupNavigationItem()
            setupTableView()
            
            setupSubviewsProfile()
            setupConstraintsProfile()
        } else {
            setupSubviewsNotAuthorized()
            setupConstraintsNotAuthorized()
        }
    }
    
    func setupTableView() {        
        tableView.register(ProfileStatsCell.self, forCellReuseIdentifier: "statsCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    func setupSubviewsProfile() {
        view.addSubview(tableView)
        view.addSubview(headerView)
        headerView.addSubview(authorView)
    }
    
    func setupConstraintsProfile() {
        tableView.contentInset = UIEdgeInsets(top: 280, left: 0, bottom: 0, right: 0)

        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupSubviewsNotAuthorized() {
        view.addSubview(loginButton)
    }
    
    func setupConstraintsNotAuthorized() {
        loginButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(100)
        }
    }
    
    func setupNavigationItem() {
        let settingsButton = UIButton()
        settingsButton.setImage(UIImage(named: "SettingsIcon"), for: .normal)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
        settingsButton.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rows = RowKind(rawValue: indexPath.row)
        switch rows {
        case .stats:
            let cell = tableView.dequeueReusableCell(withIdentifier: "statsCell", for: indexPath) as! ProfileStatsCell
            cell.setupCell(name: "ИЗМЕНИТЬ МОДЕЛЬ")
            return cell
        case .myProducts:
            let cell = tableView.dequeueReusableCell(withIdentifier: "statsCell", for: indexPath) as! ProfileStatsCell
            cell.setupCell(name: "ИЗМЕНИТЬ МОДЕЛЬ")
            return cell
        case .none:
            let cell = tableView.dequeueReusableCell(withIdentifier: "statsCell", for: indexPath) as! ProfileStatsCell
            cell.setupCell(name: "ИЗМЕНИТЬ МОДЕЛЬ")
            return cell
        }
       
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = -scrollView.contentOffset.y
        let maxHeight = max(offsetY, 50)
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: maxHeight)
        authorView.frame = CGRect(x: 0, y: maxHeight - 50, width: view.frame.width, height: 100)
        
        authorView.updateView(scrollView: scrollView)
    }
    
}

extension ProfileViewController: ProfileViewControllerProtocol {
    @objc func goToSettings() {
        presenter?.goToSettings()
    }
    
    @objc func showLoginView() {
        presenter?.goToAuthView()
    }
    
}
