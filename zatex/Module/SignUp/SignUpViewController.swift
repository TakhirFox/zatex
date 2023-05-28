//
//  SignUpSignUpViewController.swift
//  zatex
//
//  Created by winzero on 28/05/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol SignUpViewControllerProtocol: AnyObject {
    var presenter: SignUpPresenterProtocol? { get set }

}

class SignUpViewController: BaseViewController {
    
    var presenter: SignUpPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
       
    }
    
    func setupConstraints() {
    
    }
    
}

extension SignUpViewController: SignUpViewControllerProtocol {
   
}
