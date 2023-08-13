//
//  UserProfileUserProfileViewController.swift
//  zatex
//
//  Created by winzero on 13/08/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol UserProfileViewControllerProtocol: AnyObject {
    var presenter: UserProfilePresenterProtocol? { get set }

}

class UserProfileViewController: BaseViewController {
    
    var presenter: UserProfilePresenterProtocol?
    
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

extension UserProfileViewController: UserProfileViewControllerProtocol {
   
}