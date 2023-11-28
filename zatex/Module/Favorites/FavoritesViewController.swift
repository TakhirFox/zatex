//
//  FavoritesFavoritesViewController.swift
//  zatex
//
//  Created by winzero on 27/11/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol FavoritesViewControllerProtocol: AnyObject {
    var presenter: FavoritesPresenterProtocol? { get set }

}

class FavoritesViewController: BaseViewController {
    
    var presenter: FavoritesPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
       
    }
    
    func setupConstraints() {
    
    }
    
}

extension FavoritesViewController: FavoritesViewControllerProtocol {
   
}
