//
//  NewsNewsViewController.swift
//  zatex
//
//  Created by winzero on 29/11/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol NewsViewControllerProtocol: AnyObject {
    var presenter: NewsPresenterProtocol? { get set }

}

class NewsViewController: BaseViewController {
    
    var presenter: NewsPresenterProtocol?
    
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

extension NewsViewController: NewsViewControllerProtocol {
   
}
