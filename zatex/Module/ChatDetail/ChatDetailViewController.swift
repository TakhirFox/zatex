//
//  ChatDetailChatDetailViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 24/02/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol ChatDetailViewControllerProtocol: AnyObject {
    var presenter: ChatDetailPresenterProtocol? { get set }

    func setChatMesssages(data: [ChatMessageResult])
}

class ChatDetailViewController: BaseViewController {
    
    var presenter: ChatDetailPresenterProtocol?
    
    var messages: [ChatMessageResult] = []
    
    let tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.getChatMessages()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSubviews()
        setupConstraints()
    }
    
    func setupTableView() {
        tableView.register(SentChatCell.self, forCellReuseIdentifier: "sentChatCell")
        tableView.register(ReceivedChatCell.self, forCellReuseIdentifier: "receivedChatCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
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
}

extension ChatDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let myUserId: String? = UserDefaults.standard.string(forKey: "userId")
        let myUserId = "1"
        
        if messages[indexPath.row].senderID == myUserId {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sentChatCell", for: indexPath) as! SentChatCell
            cell.setupCell(messages[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "receivedChatCell", for: indexPath) as! ReceivedChatCell
            cell.setupCell(messages[indexPath.row])
            return cell
        }

    }
}

extension ChatDetailViewController: ChatDetailViewControllerProtocol {
    func setChatMesssages(data: [ChatMessageResult]) {
        DispatchQueue.main.async { [weak self] in
            self?.messages = data
            self?.tableView.reloadData()
        }
    }
}
