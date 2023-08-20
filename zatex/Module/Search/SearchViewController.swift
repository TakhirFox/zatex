//
//  SearchSearchViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 25/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol SearchViewControllerProtocol: AnyObject {
    var presenter: SearchPresenterProtocol? { get set }
    
    func setResultProducts(data: [ProductResult])
    func showError(data: String)
}

class SearchViewController: BaseViewController {
    
    var presenter: SearchPresenterProtocol?
    
    var collectionView: UICollectionView!
    let searchView = BaseTextField()
    
    var resultProducts: [ProductResult] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setVisibilityViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupSearchView()
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        searchView.snp.makeConstraints { make in
            make.width.equalTo(self.view.frame.width)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: self.view.frame.width / 2 - 24, height: 200)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.keyboardDismissMode = .onDrag
    }
    
    func setupSearchView() {
        navigationItem.titleView = searchView
        searchView.delegate = self
        searchView.placeholder = "Поиск"
    }
    
    private func setVisibilityViews() {
        collectionView.isHidden = true
        errorView.isHidden = true
        loaderView.isHidden = false
        loaderView.play()
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        presenter?.getSearchData(text: text)
        collectionView.isHidden = true
        loaderView.isHidden = false
        return true
    }
}


// MARK: CollectionView data source, delegate
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ProductCell
        cell.setupCell(resultProducts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as? HeaderCell else { return HeaderCell()}
        cell.setupCell("Результаты поиска")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let productId = self.resultProducts[indexPath.row].id else { return }
        presenter?.goToDetail(id: productId)
    }
}

// MARK: Implemented SearchViewControllerProtocol
extension SearchViewController: SearchViewControllerProtocol {
    func setResultProducts(data: [ProductResult]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.resultProducts = data
            collectionView.isHidden = false
            searchView.isHidden = false
            errorView.isHidden = true
            loaderView.isHidden = true
            self.collectionView.reloadData()
        }
    }
    
    func showError(data: String) {
        collectionView.isHidden = true
        searchView.isHidden = true
        errorView.isHidden = false
        loaderView.isHidden = true
        
        errorView.setupCell(errorName: data)
        errorView.actionHandler = { [weak self] in
            self?.setVisibilityViews()
            self?.presenter?.getSearchData(text: "")
        }
    }
}
