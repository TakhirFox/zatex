//
//  CreateProductCreateProductViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol CreateProductViewControllerProtocol: AnyObject {
    var presenter: CreateProductPresenterProtocol? { get set }

}

class CreateProductViewController: BaseViewController {
    
    var presenter: CreateProductPresenterProtocol?
    
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

extension CreateProductViewController: CreateProductViewControllerProtocol {
   
}