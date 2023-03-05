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

}

class ChatListViewController: BaseViewController {
    
    var presenter: ChatListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
       
    }
    
    func setupConstraints() {
    
    }
    
}

extension ChatListViewController: ChatListViewControllerProtocol {
   
}