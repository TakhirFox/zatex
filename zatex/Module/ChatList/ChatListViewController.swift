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
    func showError(data: String)
}

class ChatListViewController: BaseViewController {
    
    var presenter: ChatListPresenterProtocol?
    
    private let refreshControl = UIRefreshControl()
    private let tableView = UITableView()
    private let emptyView = ChatEmptyView()
    
    private var chatList: [ChatListResult] = []
    private var isPaging = false
    private var currentPage = 1
    private var isFirstLoading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSubviews()
        setupEmptyView()
        setupConstraints()
        getRequests()
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
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
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
    
    private func getRequests() {
        presenter?.getChatList(page: currentPage)
        
        tableView.isHidden = true
        emptyView.isHidden = true
        errorView.isHidden = true
        loaderView.isHidden = false
        loaderView.play()
    }
}

extension ChatListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return chatList.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatListCell
        cell.setupCell(chatList[indexPath.row])
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        presenter?.routeToMessage(chatId: chatList[indexPath.row].chatID)
    }
}

extension ChatListViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let collectionSize = tableView.contentSize.height
        let scrollSize = scrollView.frame.size.height
        let basicSize = collectionSize - 400 - scrollSize
        
        if position > basicSize {
            if isPaging == true {
                presenter?.getChatList(
                    page: currentPage
                )
                
                isPaging = false
            }
        }
    }
}

extension ChatListViewController: ChatListViewControllerProtocol {
    
    @objc private func refreshData(_ sender: Any) {
        currentPage = 1
        
        presenter?.getChatList(page: currentPage)
    }
    
    func setChatList(data: [ChatListResult]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if currentPage == 1 {
                chatList = []
            }
            
            if isFirstLoading && data.isEmpty {
                self.emptyView.isHidden = false
            }
            
            self.isFirstLoading = false
            self.chatList += data
            self.isPaging = true
            self.currentPage += 1
            self.tableView.isHidden = false
            self.loaderView.isHidden = true
            self.loaderView.stop()
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func showError(data: String) {
        tableView.isHidden = true
        emptyView.isHidden = false
        errorView.isHidden = false
        loaderView.isHidden = true
        
        errorView.setupCell(errorName: data)
        errorView.actionHandler = { [weak self] in
            self?.getRequests()
        }
    }
}
