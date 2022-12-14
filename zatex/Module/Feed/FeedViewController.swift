//
//  FeedFeedViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol FeedViewControllerProtocol: AnyObject {
    var presenter: FeedPresenterProtocol? { get set }
    
    func setProducts(data: [ProductResult])
    func setCategories(data: [CategoryResult])
    func setBanners(data: [BannerResult])
    func setProductFromCategory(data: [ProductResult])
}

class FeedViewController: BaseViewController {
    enum SectionKind: Int, CaseIterable {
        case banner, category, products
        
        var columnCount: Int {
            switch self {
            case .banner:
                return 1
            case .category:
                return 2
            case .products:
                return 3
            }
        }
    }
    
    var presenter: FeedPresenterProtocol?
    
    private var isPaging = false
    private var pageCount = 1
    
    var banners: [BannerResult] = []
    var categories: [CategoryResult] = []
    var products: [ProductResult] = []
    
    let refreshControl = UIRefreshControl()
    let searchView = BaseTextField()
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<SectionKind, AnyHashable>! = nil
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        presenter?.getProducts(page: pageCount)
        presenter?.getCategories()
        presenter?.getBanners()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupCollectionView()
        setupSearchView()
        
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        view.addSubview(searchView)
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        searchView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.register(CategoryFeedCell.self, forCellWithReuseIdentifier: "categoryCell")
        collectionView.register(BannerFeedCell.self, forCellWithReuseIdentifier: "bannerCell")
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: "headerCell", withReuseIdentifier: "headerCell")
        collectionView.refreshControl = refreshControl
        collectionView.delegate = self
        collectionView.keyboardDismissMode = .onDrag
        
        collectionView.backgroundColor = .clear
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        setupDataSource()
    }
    
    func setupSearchView() {
        searchView.delegate = self
        searchView.placeholder = "Поиск"
    }
    
}

// MARK: CollectionView flow layout, data source
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionKind, AnyHashable>(collectionView: collectionView, cellProvider: { [self] (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            let section = SectionKind(rawValue: indexPath.section)
            switch section {
            case .banner:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! BannerFeedCell
                cell.setupCell(banners[indexPath.item])
                return cell
                
            case .category:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryFeedCell
                cell.setupCell(categories[indexPath.item])
                return cell
                
            case .products:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ProductCell
                cell.setupCell(products[indexPath.item])
                return cell
                
            case .none:
                return nil
                
            }
        })
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as? HeaderCell else { return HeaderCell()}
            
            if indexPath.section == 0 {
                cell.setupCell("Горячее")
            } else if indexPath.section == 1 {
                cell.setupCell("Категории")
            } else {
                cell.setupCell("Товары")
            }
            
            return cell
        }
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, AnyHashable>()
        
        snapshot.appendSections([.banner])
        snapshot.appendItems(banners, toSection: .banner)
        
        snapshot.appendSections([.category])
        snapshot.appendItems(categories, toSection: .category)
        
        snapshot.appendSections([.products])
        snapshot.appendItems(products, toSection: .products)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = SectionKind(rawValue: sectionIndex)
            switch section {
            case .banner:
                return self.createBannerSection()
            case .category:
                return self.createCategorySection()
            case .products:
                return self.createProductsSection()
            case .none:
                return nil
            }
        }
        return layout
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 26)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(210))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "headerCell", alignment: .top)

        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    private func createCategorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(150), heightDimension: .absolute(32))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "headerCell", alignment: .top)
        
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    private func createProductsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 10, trailing: 6)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "headerCell", alignment: .top)
        
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = SectionKind(rawValue: indexPath.section)
        switch section {
        case .banner:
            print("banner")
        case .category:
            for index in 0..<self.categories.count {
                self.categories[index].selected = false
            }
            
            self.categories[indexPath.row].selected = true
            self.collectionView.reloadData()
            
            guard let categoryId = self.categories[indexPath.row].id else { return }
            presenter?.getProductByCategory(id: "\(categoryId)")
        case .products:
            guard let productId = self.products[indexPath.row].id else { return }
            presenter?.goToDetail(id: "\(productId)")
        case .none:
            print("none")
        }
    }

}

// MARK: Textfiled delegate
extension FeedViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        presenter?.goToSearchResult(text: text)
        return true
    }
    
}

// MARK: UIScrollViewDelegate
extension FeedViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let collectionSize = collectionView.contentSize.height
        let scrollSize = scrollView.frame.size.height
        let basicSize = collectionSize - 400 - scrollSize
        
        if position > basicSize {
            if isPaging == true {
                presenter?.getProducts(page: pageCount)
                isPaging = false
            }
        }
    }
    
}

// MARK: Implemented FeedViewControllerProtocol
extension FeedViewController: FeedViewControllerProtocol {
    @objc private func refreshData(_ sender: Any) {
        presenter?.getProducts(page: pageCount)
    }
    
    func setProducts(data: [ProductResult]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.products += data
            self.isPaging = true
            self.pageCount += 1
            self.reloadData()
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
            self.refreshControl.endRefreshing()
        }
    }
    
    func setCategories(data: [CategoryResult]) {        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.categories = data
            self.reloadData()
            self.collectionView.reloadData()
        }
    }
    
    func setBanners(data: [BannerResult]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.banners = data
            self.reloadData()
            self.collectionView.reloadData()
        }
    }
    
    func setProductFromCategory(data: [ProductResult]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.products = data
            self.reloadData()
            self.collectionView.reloadData()
        }
    }
    
}
