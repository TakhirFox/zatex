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
    
    func setFavoriteList(data: [ProductResult])
    func showError(data: String)
    func showToastAddError(text: String)
    func showToastRemoveError(text: String)
}

class FavoritesViewController: BaseViewController {
    
    var presenter: FavoritesPresenterProtocol?
    
    private var collectionView: UICollectionView!
    private let emptyView = EmptyFavoriteView()
    private let refreshControl = UIRefreshControl()
    
    private var productEntity: [ProductResult] = []
    private var isPaging = false
    private var currentPage = 1
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getRequests()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupEmptyView()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(collectionView)
        collectionView.addSubview(emptyView)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY)
        }
    }
    
    private func setupCollectionView() {
        title = "Избранное"
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: self.view.frame.width / 2 - 24, height: 200)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.refreshControl = refreshControl
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    private func setupEmptyView() {
        emptyView.setupCell(text: "У вас нет избранных товаров!")
    }
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productEntity.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ProductCell
        cell.setupCell(productEntity[indexPath.row])
        
        cell.onSignal = { [weak self] signal in
            guard let productId = self?.productEntity[indexPath.row].id else { return }
            
            switch signal {
            case .addFavorite:
                self?.presenter?.addFavorite(productId: productId)
                cell.changeFavorite(true)
                
            case .removeFavorite:
                self?.presenter?.removeFavorite(productId: productId)
                cell.changeFavorite(false)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let productId = self.productEntity[indexPath.row].id else { return }
        presenter?.goToDetail(id: productId)
    }
}

extension FavoritesViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let collectionSize = collectionView.contentSize.height
        let scrollSize = scrollView.frame.size.height
        let basicSize = collectionSize - 400 - scrollSize
        
        if position > basicSize {
            if isPaging == true {
                presenter?.getFavoriteList(
                    page: currentPage
                )
                
                isPaging = false
            }
        }
    }
}

extension FavoritesViewController { // TODO: Решить
    
    @objc private func refreshData(_ sender: Any) {
//        productEntity = []
//        currentPage = 1
//        
//        presenter?.getFavoriteList(page: currentPage)
    }
    
    private func getRequests() {
        presenter?.getFavoriteList(page: currentPage)
        
        collectionView.isHidden = true
        errorView.isHidden = true
        emptyView.isHidden = true
        loaderView.isHidden = false
        loaderView.play()
    }
    
    private func showLoader(enable: Bool) {
        if enable {
            loaderView.play()
        } else {
            loaderView.stop()
        }
        
        loaderView.isHidden = !enable
        collectionView.alpha = enable ? 0.5 : 1
        collectionView.isUserInteractionEnabled = !enable
    }
}

extension FavoritesViewController: FavoritesViewControllerProtocol {
   
    func setFavoriteList(data: [ProductResult]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if currentPage == 1 {
                self.emptyView.isHidden = !data.isEmpty
            }
            
            self.productEntity += data
            self.isPaging = true
            self.currentPage += 1
            self.collectionView.isHidden = false
            self.errorView.isHidden = true
            self.loaderView.isHidden = true
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func showError(data: String) {
        collectionView.isHidden = true
        errorView.isHidden = false
        loaderView.isHidden = true
        emptyView.isHidden = false
        
        errorView.setupCell(errorName: data)
        errorView.actionHandler = { [weak self] in
            self?.getRequests()
        }
    }
    
    func showToastAddError(text: String) {
        toastAnimation(text: text) { [weak self] in
            self?.presenter?.addFavorite(productId: 0)
            self?.showLoader(enable: true)
        }
        
        showLoader(enable: false)
    }
    
    func showToastRemoveError(text: String) {
        toastAnimation(text: text) { [weak self] in
            self?.presenter?.removeFavorite(productId: 0)
            self?.showLoader(enable: true)
        }
        
        showLoader(enable: false)
    }
}
