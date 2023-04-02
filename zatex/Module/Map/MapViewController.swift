//
//  MapMapViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 02/04/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol MapViewControllerProtocol: AnyObject {
    var presenter: MapPresenterProtocol? { get set }

}

class MapViewController: BaseViewController {
    
    var presenter: MapPresenterProtocol?
    
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

extension MapViewController: MapViewControllerProtocol {
   
}