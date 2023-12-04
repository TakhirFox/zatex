//
//  SelectCitySelectCityViewController.swift
//  zatex
//
//  Created by winzero on 05/12/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol SelectCityViewControllerProtocol: AnyObject {
    
    var presenter: SelectCityPresenterProtocol? { get set }
    
    func showCountries(data: [String])
    func showCities(data: [String])
    
    func showError(data: String)
}

class SelectCityViewController: BaseViewController {
    
    var presenter: SelectCityPresenterProtocol?
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let buttonView = SaveCityButtonView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        view.addSubview(buttonView)
    }
    
    private func setupConstraints() {
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
        title = "Найти город"
        
        tableView.register(AvatarAddInfoCell.self, forCellReuseIdentifier: "avatarImageCell")
        tableView.register(FieldAddInfoCell.self, forCellReuseIdentifier: "firstnameFieldCell")
        tableView.register(FieldAddInfoCell.self, forCellReuseIdentifier: "lastnameFieldCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    private func setupButtonView() {
        buttonView.setupView(title: "Сохранить")
        buttonView.sendButton.addTarget(self, action: #selector(saveAndDismiss), for: .touchUpInside)
    }
}

extension SelectCityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "avatarImageCell", for: indexPath) as! AvatarAddInfoCell
        cell.setupCell(image: additionalInfo.avatar)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension SelectCityViewController {
    @objc private func saveAndDismiss() {
        
    }
}

extension SelectCityViewController: SelectCityViewControllerProtocol {
    
    func showCountries(data: [String]) {
        
    }
    
    func showCities(data: [String]) {
        
    }
    
    func showError(data: String) {
        tableView.isHidden = true
        errorView.isHidden = false
        loaderView.isHidden = true
        
        errorView.setupCell(errorName: data)
    }
}
