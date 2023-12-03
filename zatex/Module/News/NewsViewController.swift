//
//  NewsNewsViewController.swift
//  zatex
//
//  Created by winzero on 29/11/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit
import Kingfisher
import WebKit

protocol NewsViewControllerProtocol: AnyObject {
    var presenter: NewsPresenterProtocol? { get set }
    
    func showNewsContent(data: BannerResult)
}

class NewsViewController: BaseViewController {
    
    var presenter: NewsPresenterProtocol?
    
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
        setupConstraints()
        
        presenter?.setNewsContent()
    }
    
    func setupSubviews() {
        view.addSubview(webView)
    }
    
    func setupConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension NewsViewController: NewsViewControllerProtocol {
    
    func showNewsContent(data: BannerResult) {
        webView.loadHTMLString(data.description, baseURL: nil)
    }
}
