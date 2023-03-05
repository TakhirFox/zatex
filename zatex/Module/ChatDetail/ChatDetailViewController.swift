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

}

class ChatDetailViewController: BaseViewController {
    
    var presenter: ChatDetailPresenterProtocol?
    
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

extension ChatDetailViewController: ChatDetailViewControllerProtocol {
   
}