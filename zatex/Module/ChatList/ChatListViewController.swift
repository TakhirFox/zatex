//
//  ChatListChatListViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 24/02/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol ChatListViewControllerProtocol: AnyObject {
    var presenter: ChatListPresenterProtocol? { get set }
    
    func setChatList(data: [ChatListResult])
}

class ChatListViewController: BaseViewController {
    
    var presenter: ChatListPresenterProtocol?
    
    var chatList: [ChatListResult] = []
    
    let refreshControl = UIRefreshControl()
    let tableView = UITableView()
    let emptyView = ChatEmptyView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.getChatList()
        
        tableView.isHidden = true
        emptyView.isHidden = true
        loaderView.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSubviews()
        setupEmptyView()
        setupConstraints()
    }
    
    private func setupTableView() {
        title = "Сообщения"
        
        tableView.register(ChatListCell.self, forCellReuseIdentifier: "chatCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        tableView.addSubview(emptyView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupEmptyView() {
        emptyView.setupCell(text: "Вам пока никто не писал!")
    }
}

extension ChatListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatListCell
        cell.setupCell(chatList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.routeToMessage(chatId: chatList[indexPath.row].chatID)
    }
}

extension ChatListViewController: ChatListViewControllerProtocol {
    
    @objc private func refreshData(_ sender: Any) {
        presenter?.getChatList()
    }
    
    func setChatList(data: [ChatListResult]) {
        DispatchQueue.main.async { [weak self] in
            self?.chatList = data
            self?.tableView.isHidden = false
            self?.emptyView.isHidden = !data.isEmpty
            self?.loaderView.isHidden = true
            self?.loaderView.stop()
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
}
