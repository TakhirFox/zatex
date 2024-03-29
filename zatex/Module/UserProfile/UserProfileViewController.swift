//
//  UserProfileUserProfileViewController.swift
//  zatex
//
//  Created by winzero on 13/08/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit
import Kingfisher

protocol UserProfileViewControllerProtocol: AnyObject {
    var presenter: UserProfilePresenterProtocol? { get set }
    
    func setStoreInfo(data: StoreInfoResult)
    func setStoreProduct(data: [ProductResult])
    func setStats(activeCount: String, salesCount: String)
    func showError(data: String)
}

class UserProfileViewController: BaseViewController {
    
    enum RowKind: Int {
        case stats, productSection, profileProducts
    }
    
    var presenter: UserProfilePresenterProtocol?
    var userId: Int?
    
    private var profileStoreInfo: StoreInfoResult?
    private var profileProducts: [ProductResult] = []
    private var isLoadedProducts = false
    private var productStats = (active: "0", sales: "0")
    private var isPaging = false
    private var currentPage = 1
    private var saleStatus: ProductResult.SaleStatus = .publish

    private var collectionView: UICollectionView!
    private let headerView = UserProfileHeaderView()
    private let authorView = UserProfileAuthorView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getRequests()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupSubviews()
        setupConstraints()
        setupNavigationItem()
        loadProfileView()
    }
    
    private func loadProfileView() {
        if userId != nil {
            navigationController?.isNavigationBarHidden = false
            collectionView.isHidden = false
            headerView.isHidden = false
        } else {
            navigationController?.isNavigationBarHidden = true
            collectionView.isHidden = true
            headerView.isHidden = true
        }
    }
    
    private func setupCollectionView() {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UserProfileStatsCell.self, forCellWithReuseIdentifier: "statsCell")
        collectionView.register(UserProfileProductCell.self, forCellWithReuseIdentifier: "productCell")
        collectionView.register(UserProfileSectionCell.self, forCellWithReuseIdentifier: "sectionCell")
        collectionView.register(UserProfileEmptyCell.self, forCellWithReuseIdentifier: "emptyCell")
        collectionView.register(UserProfileLoaderCell.self, forCellWithReuseIdentifier: "loaderCell")

        collectionView.backgroundColor = .clear
    }
    
    private func setupSubviews() {
        view.addSubview(collectionView)
        view.addSubview(headerView)
        headerView.addSubview(authorView)
    }
    
    private func setupConstraints() {
        collectionView.contentInset = UIEdgeInsets(top: 280, left: 16, bottom: 0, right: 16)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(65)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupNavigationItem() {
        let settingsButton = UIButton()
        settingsButton.setImage(UIImage(named: "share-icon-dark"), for: .normal)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
        settingsButton.addTarget(self, action: #selector(sharePageAction), for: .touchUpInside)
    }
    
    private func getRequests() {
        if let userId = userId {
            presenter?.getStoreInfo(authorId: userId)
            
            presenter?.getStoreProduct(
                authorId: userId,
                currentPage: currentPage,
                saleStatus: ProductResult.SaleStatus.publish.rawValue
            )
            
            presenter?.getProductStats(authorId: userId)
        }
        
        collectionView.isHidden = true
        headerView.isHidden = true
        authorView.isHidden = true
        errorView.isHidden = true
        loaderView.isHidden = false
        loaderView.play()
    }
    
    private func getFilteredRequests(saleStatus: ProductResult.SaleStatus) {
        if let userId = userId {
            self.currentPage = 1
            self.saleStatus = saleStatus
            self.profileProducts = []
            self.isLoadedProducts = false
            self.collectionView.reloadData()
            
            presenter?.getStoreProduct(
                authorId: userId,
                currentPage: currentPage,
                saleStatus: saleStatus.rawValue
            )
        }
    }
}

extension UserProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
            
        case .profileProducts:
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "statsCell", for: indexPath) as! UserProfileStatsCell
            cell.setupCell(rating: profileStoreInfo, stats: productStats)
            cell.onSignal = { [weak self] signal in
                switch signal {
                case .stats:
                    self?.goToReviews()
                    
                case .active:
                    self?.getFilteredRequests(saleStatus: .publish)
                    
                case .sales:
                    self?.getFilteredRequests(saleStatus: .draft)
                }
            }
            return cell
            
        case .productSection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sectionCell", for: indexPath) as! UserProfileSectionCell
            let storeName = profileStoreInfo?.storeName ?? ""
            cell.setupCell(name: "Товары \(storeName)")
            return cell
            
        case .profileProducts:
            if !isLoadedProducts {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loaderCell", for: indexPath) as! UserProfileLoaderCell
                cell.setupCell()
                return cell
                
            } else if !profileProducts.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! UserProfileProductCell
                cell.setupCell(profileProducts[indexPath.row])
                return cell
                
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyCell", for: indexPath) as! UserProfileEmptyCell
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
            
        case .profileProducts:
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
            
        case .profileProducts:
            let idProduct = profileProducts[indexPath.item].id ?? 0
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

extension UserProfileViewController {
    
    @objc func sharePageAction() {
        guard let userId = profileStoreInfo?.id,
              let name = profileStoreInfo?.storeName else { return }
        
        let text = "Посмотри товары продавца \(name)"
        let url = URL(string: "zatexmobile://profile?userID=\(userId)")!
        
        var shareAll: [Any] = [text, url]
                               
        if let imageUrl = profileStoreInfo?.gravatar as? String {
            let processedImage = (imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            let urlString = URL(string: processedImage)!
            
            KingfisherManager.shared.retrieveImage(with: urlString) { result in
                switch result {
                case .success(let image):
                    shareAll.append(image.image)
                    
                case .failure:
                    break
                }
            }
        }
        
        let activityView = UIActivityViewController(
            activityItems: shareAll,
            applicationActivities: nil
        )
        
        present(activityView, animated: true)
    }
    
    @objc func goToReviews() {
        guard let userId = userId else { return }
        presenter?.goToReview(id: String(userId))
    }
}

extension UserProfileViewController: UserProfileViewControllerProtocol {
   
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
            self?.profileProducts += data
            self?.collectionView.isHidden = false
            self?.isLoadedProducts = true
            self?.isPaging = true
            self?.currentPage += 1
            self?.collectionView.reloadData()
        }
    }
    
    func setStats(activeCount: String, salesCount: String) {
        DispatchQueue.main.async { [weak self] in
            self?.productStats.active = activeCount
            self?.productStats.sales = salesCount
            self?.collectionView.reloadData()
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
