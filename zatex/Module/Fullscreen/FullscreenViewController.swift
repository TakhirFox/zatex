//
//  FullscreenFullscreenViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/05/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit
import Kingfisher

protocol FullscreenViewControllerProtocol: AnyObject {
    var presenter: FullscreenPresenterProtocol? { get set }

}

class FullscreenViewController: BaseViewController {
    
    var presenter: FullscreenPresenterProtocol?
    var images: [String] = []
    
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.kf.setImage(with: URL(string: images[0])!)
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        view.backgroundColor = .black
        
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
       
    }
    
    func setupConstraints() {
    
    }
    
}

extension FullscreenViewController: FullscreenViewControllerProtocol {
   
}
