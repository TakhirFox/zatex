//
//  ReviewsReviewsViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 20/03/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol ReviewsViewControllerProtocol: AnyObject {
    var presenter: ReviewsPresenterProtocol? { get set }

}

class ReviewsViewController: BaseViewController {
    
    var presenter: ReviewsPresenterProtocol?
    
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

extension ReviewsViewController: ReviewsViewControllerProtocol {
   
}