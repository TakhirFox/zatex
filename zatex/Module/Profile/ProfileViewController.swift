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
    func setStats(activeCount: String, salesCount: String)
    func updateView()
    func showError(data: String)
}

class ProfileViewController: BaseViewController {
    
    enum RowKind: Int {
        case stats, productSection, myProducts
    }
    
    var presenter: ProfilePresenterProtocol?
    var sessionProvider: SessionProvider?
    
    private var profileStoreInfo: StoreInfoResult?
    private var profileProducts: [ProductResult] = []
    private var isLoadedProducts = false
    private var productStats = (active: "0", sales: "0")
    private var userId: Int?
    private var isPaging = false
    private var currentPage = 1
    private var saleStatus: ProductResult.SaleStatus = .publish
    
    private var collectionView: UICollectionView!
    private let headerView = ProfileHeaderView()
    private let authorView = ProfileAuthorView()
    private let loginView = ProfileLoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        setupCollectionView()
        setupSubviews()
        setupConstraints()
        loadProfileView()
        setupLoginView()
        hideNavigationView()
    }
    
    private func loadProfileView() {
        if sessionProvider != nil,
           sessionProvider!.isAuthorized
        {
            getRequests()
            
            navigationController?.isNavigationBarHidden = false
            collectionView.isHidden = false
            headerView.isHidden = false
            loginView.isHidden = true
        } else {
            profileStoreInfo = nil
            profileProducts = []
            collectionView.reloadData()
            
            navigationController?.isNavigationBarHidden = true
            collectionView.isHidden = true
            headerView.isHidden = true
            loginView.isHidden = false
        }
    }
    
    private func setupCollectionView() {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProfileStatsCell.self, forCellWithReuseIdentifier: "statsCell")
        collectionView.register(ProfileProductCell.self, forCellWithReuseIdentifier: "productCell")
        collectionView.register(ProfileSectionCell.self, forCellWithReuseIdentifier: "sectionCell")
        collectionView.register(ProfileEmptyCell.self, forCellWithReuseIdentifier: "emptyCell")
        collectionView.register(ProfileLoaderCell.self, forCellWithReuseIdentifier: "loaderCell")
        collectionView.backgroundColor = .clear
    }
    
    private func setupSubviews() {
        view.addSubview(loginView)
        view.addSubview(collectionView)
        view.addSubview(headerView)
        headerView.addSubview(authorView)
    }
    
    private func setupConstraints() {
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.contentInset = UIEdgeInsets(top: 280, left: 16, bottom: 16, right: 16)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(65)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupNavigationItem() {
        let settingsButton = UIButton()
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
        
        switch Appearance.shared.theme.value {
        case .dark:
            settingsButton.setImage(UIImage(named: "DarkSettingsIcon"), for: .normal)
            
        case .light:
            settingsButton.setImage(UIImage(named: "SettingsIcon"), for: .normal)
        }
    }
    
    func hideNavigationView() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    private func getRequests() {
        userId = Int(sessionProvider?.getSession()?.userId ?? "")
        
        if let id = userId {
            presenter?.getStoreInfo(authorId: id)
            
            presenter?.getStoreProduct(
                authorId: id,
                currentPage: currentPage,
                saleStatus: ProductResult.SaleStatus.publish.rawValue
            )
            
            presenter?.getProductStats(authorId: id)
            presenter?.saveDeviceToken(authorId: id)
        }
        
        collectionView.isHidden = true
        headerView.isHidden = true
        authorView.isHidden = true
        errorView.isHidden = true
        
        if sessionProvider != nil,
           sessionProvider!.isAuthorized {
            loaderView.isHidden = false
            loaderView.play()
        } else {
            loaderView.isHidden = true
            loaderView.stop()
        }
    }
    
    private func getFilteredRequests(saleStatus: ProductResult.SaleStatus) {
        if let id = userId {
            self.currentPage = 1
            self.saleStatus = saleStatus
            self.profileProducts = []
            self.isLoadedProducts = false
            self.collectionView.reloadData()
            
            presenter?.getStoreProduct(
                authorId: id,
                currentPage: currentPage,
                saleStatus: saleStatus.rawValue
            )
        }
    }
    
    private func setupLoginView() {
        loginView.setupCell()
        loginView.actionHandler = { [weak self] in
            self?.showLoginView()
        }
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        let rows = RowKind(rawValue: section)
        switch rows {
        case .stats:
            return 1
            
        case .productSection:
            return 1
            
        case .myProducts:
            let count = profileProducts.count
            return count == 0 ? 1 : count
            
        case .none:
            return 0
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let rows = RowKind(rawValue: indexPath.section)
        switch rows {
        case .stats:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "statsCell", for: indexPath) as! ProfileStatsCell
            cell.setupCell(rating: profileStoreInfo, stats: productStats)
            cell.onSignal = { [weak self] signal in
                switch signal {
                case .stats:
                    self?.goToReviews()
                    
                case .active:
                    self?.getFilteredRequests(saleStatus: .publish)
                    self?.saleStatus = .publish
                    
                case .sales:
                    self?.getFilteredRequests(saleStatus: .draft)
                    self?.saleStatus = .draft
                }
            }
            return cell
            
        case .productSection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sectionCell", for: indexPath) as! ProfileSectionCell
            let storeName = profileStoreInfo?.storeName ?? ""
            cell.setupCell(name: "Товары \(storeName)")
            return cell
            
        case .myProducts:
            if !isLoadedProducts {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loaderCell", for: indexPath) as! ProfileLoaderCell
                cell.setupCell()
                return cell
                
            } else if !profileProducts.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProfileProductCell
                cell.setupCell(profileProducts[indexPath.row])
                cell.onSignal = { [weak self] signal in
                    self?.changeStateProduct(
                        signal: signal,
                        index: indexPath.row)
                }
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
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let rows = RowKind(rawValue: indexPath.section)
        switch rows {
        case .stats:
            return .init(width: view.frame.width - 32, height: 130)
            
        case .productSection:
            return .init(width: view.frame.width, height: 45)
            
        case .myProducts:
            let isEmpty = profileProducts.isEmpty
            
            return .init(
                width: isEmpty ? view.frame.width : view.frame.width / 2 - 24,
                height: 230
            )
            
        case .none:
            return .zero
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let rows = RowKind(rawValue: indexPath.section)
        switch rows {
        case .stats:
            return
            
        case .productSection:
            return
            
        case .myProducts:
            if !profileProducts.isEmpty {
                let idProduct = profileProducts[indexPath.item].id ?? 0
                presenter?.goToDetail(id: idProduct)
            }
            
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
        
        
        let position = scrollView.contentOffset.y
        let collectionSize = collectionView.contentSize.height
        let scrollSize = scrollView.frame.size.height
        let basicSize = collectionSize - 400 - scrollSize
        
        if position > basicSize {
            if isPaging == true {
                guard let userId = userId else { return }
                presenter?.getStoreProduct(
                    authorId: userId,
                    currentPage: currentPage,
                    saleStatus: saleStatus.rawValue
                )
                
                isPaging = false
            }
        }
    }
}

extension ProfileViewController {
    
    private func changeStateProduct(
        signal: ProfileProductCell.Signal,
        index: Int
    ) {
        guard let productId = self.profileProducts[index].id else { return }
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            
            switch signal {
            case .toActive:
                strongSelf.presenter?.setSalesProfuct(
                    productId: productId,
                    saleStatus: ProductResult.SaleStatus.publish.rawValue,
                    authorId: strongSelf.userId ?? 0
                )
                                                
            case .toSales:
                strongSelf.presenter?.setSalesProfuct(
                    productId: productId,
                    saleStatus: ProductResult.SaleStatus.draft.rawValue,
                    authorId: strongSelf.userId ?? 0
                )
            }
            
            strongSelf.profileProducts.remove(at: index)
            strongSelf.collectionView.reloadSections(IndexSet(integer: 2))
        }
    }
    
    @objc func goToSettings() {
        presenter?.goToSettings()
    }
    
    @objc func showLoginView() {
        presenter?.goToAuthView()
    }
    
    @objc func goToReviews() {
        guard let userId = userId else { return }
        presenter?.goToReview(id: String(userId))
    }
}

extension ProfileViewController: ProfileViewControllerProtocol {
    
    func setStoreInfo(data: StoreInfoResult) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.profileStoreInfo = data
            self.headerView.setupCell(store: data)
            self.authorView.setupCell(store: data)
            self.headerView.isHidden = false
            self.authorView.isHidden = false
            self.loaderView.isHidden = true
            self.loaderView.stop()
            self.collectionView.reloadData()
        }
    }
    
    func setStoreProduct(data: [ProductResult]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if !data.isEmpty && data.first?.saleStatus != self.saleStatus {
                self.profileProducts = []
            }
            
            self.profileProducts += data
            self.collectionView.isHidden = false
            self.isLoadedProducts = true
            self.isPaging = true
            self.currentPage += 1
            self.collectionView.reloadData()
        }
    }
    
    func setStats(activeCount: String, salesCount: String) {
        DispatchQueue.main.async { [weak self] in
            self?.productStats.active = activeCount
            self?.productStats.sales = salesCount
            self?.collectionView.reloadData()
        }
    }
    
    func updateView() {
        DispatchQueue.main.async { [weak self] in
            self?.loadProfileView()
        }
    }
    
    func showError(data: String) {
        collectionView.isHidden = true
        headerView.isHidden = true
        authorView.isHidden = true
        errorView.isHidden = false
        loaderView.isHidden = true
        
        errorView.setupCell(errorName: data)
        errorView.actionHandler = { [weak self] in
            self?.getRequests()
        }
    }
}
