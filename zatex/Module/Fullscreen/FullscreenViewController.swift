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
    var selectedId: Int = 0
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.isPagingEnabled = true
        view.isScrollEnabled = true
        return view
    }()
    
    private let hideNavigationGesture: UITapGestureRecognizer = {
        let view = UITapGestureRecognizer()
        return view
    }()
    
    
    private let imageNavigationView = FullscreenNavigationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black

        setupScrollView()
        setupNavigationView()
        setupSubviews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.contentSize = CGSize(
            width: scrollView.frame.size.width * CGFloat(images.count),
            height: scrollView.frame.size.height
        )
        
        let x = self.view.frame.size.width * CGFloat(selectedId)
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    
    private func setupSubviews() {
        view.addSubview(scrollView)
        view.addSubview(imageNavigationView)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageNavigationView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    private func setupNavigationView() {
        view.addGestureRecognizer(hideNavigationGesture)
        hideNavigationGesture.addTarget(self, action: #selector(hideShowNavigation))
        
        imageNavigationView.closeButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        
        imageNavigationView.setCounter(
            selectedId: selectedId,
            countImages: images.count
        )
    }
    
    private func setupScrollView() {
        for index in 0..<images.count {
            let imageView = UIImageView()
            let x = self.view.frame.size.width * CGFloat(index)
            imageView.frame = CGRect(x: x, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            imageView.contentMode = .scaleAspectFit
            imageView.kf.setImage(with: URL(string: images[index])!)

            scrollView.contentSize.width = scrollView.frame.size.width * CGFloat(index + 1)
            scrollView.addSubview(imageView)
        }
        
        scrollView.delegate = self
    }
    
    @objc func closeView() {
        self.dismiss(animated: true)
    }
    
    @objc func hideShowNavigation() {
        UIView.animate(withDuration: 0.3) {
            self.imageNavigationView.alpha = self.imageNavigationView.alpha == 0 ? 1 : 0
        }
    }
}

extension FullscreenViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x/scrollView.frame.size.width
        
        imageNavigationView.setCounter(
            selectedId: Int(page),
            countImages: images.count
        )
    }
}

extension FullscreenViewController: FullscreenViewControllerProtocol {
   
}
