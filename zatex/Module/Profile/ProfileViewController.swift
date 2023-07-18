//
//  ProfileProfileViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }

    func setStoreInfo(data: StoreInfoResult)
    func setStoreProduct(data: [ProductResult])
    func updateView()
}

class ProfileViewController: BaseViewController {
    
    enum RowKind: Int {
        case stats, productSection, myProducts
    }
    
    var presenter: ProfilePresenterProtocol?
    
    var sessionProvider: SessionProvider?
    var profileStoreInfo: StoreInfoResult?
    var profileProducts: [ProductResult]?
    
    var collectionView: UICollectionView!
    let headerView = ProfileHeaderView()
    let authorView = ProfileAuthorView()
    
    let loginButton: UIButton = {
        let view = UIButton()
        view.setTitle("Войти", for: .normal)
        view.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 15)
        view.addTarget(nil, action: #selector(showLoginView), for: .touchUpInside)
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let userId = sessionProvider?.getSession()?.userId,
           let id = Int(userId) {
            presenter?.getStoreInfo(authorId: id)
            presenter?.getStoreProduct(authorId: id)
        }
        
        self.hideNavigationView()
        
        collectionView.isHidden = true
        headerView.isHidden = true
        authorView.isHidden = true
        
        if sessionProvider != nil,
           sessionProvider!.isAuthorized
        {
            loaderView.isHidden = false
        } else {
            loaderView.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        setupCollectionView()
        setupSubviews()
        setupConstraints()
        loadProfileView()
    }
    
    func loadProfileView() {
        if sessionProvider != nil,
           sessionProvider!.isAuthorized
        {
            navigationController?.isNavigationBarHidden = false
            collectionView.isHidden = false
            headerView.isHidden = false
            loginButton.isHidden = true
        } else {
            navigationController?.isNavigationBarHidden = true
            collectionView.isHidden = true
            headerView.isHidden = true
            loginButton.isHidden = false
        }
    }
    
    func setupCollectionView() {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProfileStatsCell.self, forCellWithReuseIdentifier: "statsCell")
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "productCell")
        collectionView.register(ProfileSectionCell.self, forCellWithReuseIdentifier: "sectionCell")
        collectionView.register(ProfileEmptyCell.self, forCellWithReuseIdentifier: "emptyCell")
        collectionView.backgroundColor = .clear
    }
    
    func setupSubviews() {
        view.addSubview(loginButton)
        view.addSubview(collectionView)
        view.addSubview(headerView)
        headerView.addSubview(authorView)
    }
    
    func setupConstraints() {
        loginButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(100)
        }
        
        collectionView.contentInset = UIEdgeInsets(top: 280, left: 16, bottom: 0, right: 16)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(65)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupNavigationItem() {
        let settingsButton = UIButton()
        settingsButton.setImage(UIImage(named: "SettingsIcon"), for: .normal)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
        settingsButton.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
    }
    
    func hideNavigationView() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        let rows = RowKind(rawValue: section)
        switch rows {
        case .stats:
            return 1
            
        case .productSection:
            return 1
            
        case .myProducts:
            let count = profileProducts?.count ?? 0
            return count == 0 ? 1 : count
            
        case .none:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let rows = RowKind(rawValue: indexPath.section)
        switch rows {
        case .stats:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "statsCell", for: indexPath) as! ProfileStatsCell
            cell.setupCell(stats: profileStoreInfo)
            cell.countRatingLabel.addTarget(self, action: #selector(goToReviews), for: .touchUpInside)
            cell.nameRatingLabel.addTarget(self, action: #selector(goToReviews), for: .touchUpInside)
            return cell
            
        case .productSection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sectionCell", for: indexPath) as! ProfileSectionCell
            let storeName = profileStoreInfo?.storeName ?? ""
            cell.setupCell(name: "Товары \(storeName)")
            return cell
            
        case .myProducts:
            if profileProducts != nil, !profileProducts!.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCell
                cell.setupCell(profileProducts?[indexPath.row])
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyCell", for: indexPath) as! ProfileEmptyCell
                cell.setupCell(text: "Тут пока ничего нет")
                return cell
            }
            
        case .none:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let rows = RowKind(rawValue: indexPath.section)
        switch rows {
        case .stats:
            return .init(width: view.frame.width - 32, height: 130)
            
        case .productSection:
            return .init(width: view.frame.width, height: 45)
            
        case .myProducts:
            let isEmpty = profileProducts?.isEmpty ?? false
            
            return .init(
                width: isEmpty ? view.frame.width : view.frame.width / 2 - 24,
                height: 200
            )
            
        case .none:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let rows = RowKind(rawValue: indexPath.section)
        switch rows {
        case .stats:
            return
            
        case .productSection:
            return
            
        case .myProducts:
            let idProduct = profileProducts?[indexPath.item].id ?? 0
            presenter?.goToDetail(id: idProduct)
            
        case .none:
            return
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = -scrollView.contentOffset.y
        let maxHeight = max(offsetY, 50)
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: maxHeight)
        authorView.frame = CGRect(x: 0, y: maxHeight - 50, width: view.frame.width, height: 100)
        
        authorView.updateView(scrollView: scrollView)
    }
}

extension ProfileViewController {
    
    @objc func goToSettings() {
        presenter?.goToSettings()
    }
    
    @objc func showLoginView() {
        presenter?.goToAuthView()
    }
    
    @objc func goToReviews() {
        guard let userId = sessionProvider?.getSession()?.userId else { return }
        presenter?.goToReview(id: userId)
    }
}

extension ProfileViewController: ProfileViewControllerProtocol {
    
    func setStoreInfo(data: StoreInfoResult) {
        DispatchQueue.main.async { [weak self] in
            self?.profileStoreInfo = data
            self?.headerView.setupCell(store: data)
            self?.authorView.setupCell(store: data)
            self?.headerView.isHidden = false
            self?.authorView.isHidden = false
            self?.loaderView.isHidden = true
            self?.loaderView.stop()
            self?.collectionView.reloadData()
        }
    }
    
    func setStoreProduct(data: [ProductResult]) {
        DispatchQueue.main.async { [weak self] in
            self?.profileProducts = data
            self?.collectionView.isHidden = false
            self?.collectionView.reloadData()
        }
    }
    
    func updateView() {
        loadProfileView()
    }
}
