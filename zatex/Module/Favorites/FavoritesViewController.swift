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
    func showToastError(text: String)
}

class FavoritesViewController: BaseViewController {
    
    var presenter: FavoritesPresenterProtocol?
    
    var collectionView: UICollectionView!
    
    var productEntity: [ProductResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupCollectionView() {
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
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.keyboardDismissMode = .onDrag
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let productId = self.productEntity[indexPath.row].id else { return }
        presenter?.goToDetail(id: productId)
    }
}

extension FavoritesViewController: FavoritesViewControllerProtocol {
   
    func setFavoriteList(data: [ProductResult]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.productEntity = data
//            collectionView.isHidden = false
//            searchView.isHidden = false
//            errorView.isHidden = true
//            loaderView.isHidden = true
            self.collectionView.reloadData()
        }
    }
    
    func showError(data: String) {
        
    }
    
    func showToastError(text: String) {
        
    }
}
