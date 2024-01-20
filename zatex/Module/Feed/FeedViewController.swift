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
    func showError(data: String)
    func showToastError(text: String)
}

class FeedViewController: BaseViewController {
    enum SectionKind: Int, CaseIterable {
        case myCity, banner, category, products, emptyCategory
        
        var columnCount: Int {
            switch self {
            case .myCity:
                return 1
                
            case .banner:
                return 2
                
            case .category:
                return 3
                
            case .products:
                return 4
                
            case .emptyCategory:
                return 5
            }
        }
    }
    
    var presenter: FeedPresenterProtocol?
    
    private var isPaging = false
    private var currentPage = 1
    private var categoryId: Int?
    
    private var banners: [BannerResult] = []
    private var categories: [CategoryResult] = []
    private var products: [ProductResult] = []
    private var emptyProducts: [String] = []
    
    private let refreshControl = UIRefreshControl()
    private let searchView = BaseTextField()
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<SectionKind, AnyHashable>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupSearchView()
        setupSubviews()
        setupConstraints()
        
        getRequests()
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
            make.top.equalTo(searchView.snp.bottom).offset(6)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.register(CityCell.self, forCellWithReuseIdentifier: "cityCell")
        collectionView.register(CategoryFeedCell.self, forCellWithReuseIdentifier: "categoryCell")
        collectionView.register(BannerFeedCell.self, forCellWithReuseIdentifier: "bannerCell")
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.register(EmptyProductCell.self, forCellWithReuseIdentifier: "emptyProductCell")
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
    
    private func getRequests() {
        presenter?.getProducts(
            categoryId: categoryId,
            page: currentPage
        )
        
        presenter?.getCategories()
        presenter?.getBanners()
        
        collectionView.isHidden = true
        searchView.isHidden = true
        errorView.isHidden = true
        loaderView.isHidden = false
        loaderView.play()
    }
}

// MARK: CollectionView flow layout, data source
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionKind, AnyHashable>(
            collectionView: collectionView,
            cellProvider: { [self] (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
                let section = SectionKind(rawValue: indexPath.section)
                switch section {
                case .myCity:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cityCell", for: indexPath) as! CityCell
                    let city = UserDefaults.standard.string(forKey: "MyCity") ?? "Весь мир" // TODO: Вынести
                    cell.setupCell(title: "Ваш город:", city: city)
                    return cell
                    
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
                    
                    cell.onSignal = { [weak self] signal in
                        guard let productId = self?.products[indexPath.row].id else { return }
                        
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
                    
                case .emptyCategory:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyProductCell", for: indexPath) as! EmptyProductCell
                    cell.setupCell(text: "Категория все еще пустая")
                    return cell
                    
                case .none:
                    return nil
                }
            }
        )
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as? HeaderCell else { return HeaderCell()}
            
            if indexPath.section == 0 {
                cell.setupCell("")
            } else if indexPath.section == 1 {
                cell.setupCell("Горячее")
            } else if indexPath.section == 2 {
                cell.setupCell("Категории")
            } else {
                cell.setupCell("Товары")
            }
            
            return cell
        }
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, AnyHashable>()
        
        snapshot.appendSections([.myCity])
        snapshot.appendItems([""], toSection: .myCity)
        
        snapshot.appendSections([.banner])
        snapshot.appendItems(banners, toSection: .banner)
        
        snapshot.appendSections([.category])
        snapshot.appendItems(categories, toSection: .category)
        
        snapshot.appendSections([.products])
        snapshot.appendItems(products, toSection: .products)
        
        snapshot.appendSections([.emptyCategory])
        snapshot.appendItems(emptyProducts, toSection: .emptyCategory)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = SectionKind(rawValue: sectionIndex)
            switch section {
            case .myCity:
                return self.createCitySection()
                
            case .banner:
                return self.createBannerSection()
                
            case .category:
                return self.createCategorySection()
                
            case .products:
                return self.createProductsSection()
                
            case .emptyCategory:
                return self.createEmptyCategorySection()
                
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
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(130))
        
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
    
    private func createEmptyCategorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 10, trailing: 6)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        return section
    }
    
    private func createCitySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 10, trailing: 6)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = SectionKind(rawValue: indexPath.section)
        switch section {
        case .myCity:
            presenter?.goToChangeCity()
            
        case .banner:
            let newsEntity = self.banners[indexPath.row]
            presenter?.goToNews(entity: newsEntity)
            
        case .category:
            for index in 0..<self.categories.count {
                self.categories[index].selected = false
            }
            
            self.categories[indexPath.row].selected = true
            self.collectionView.reloadData()
            
            guard let categoryId = self.categories[indexPath.row].id else { return }
            
            presenter?.getProducts(
                categoryId: categoryId,
                page: 1
            )
            
            self.categoryId = categoryId
            currentPage = 1
            products = []
            isPaging = true
            
        case .products:
            guard let productId = self.products[indexPath.row].id else { return }
            presenter?.goToDetail(id: productId)
            
        case .emptyCategory:
            break
            
        case .none:
            break
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
                presenter?.getProducts(
                    categoryId: categoryId,
                    page: currentPage
                )
                
                isPaging = false
            }
        }
    }
}

// MARK: Implemented FeedViewControllerProtocol
extension FeedViewController: FeedViewControllerProtocol {
    
    @objc private func refreshData(_ sender: Any) { // TODO: Решить
//        currentPage = 1
//        
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else { return }
//            self.products = []
//            self.reloadData()
//            self.collectionView.reloadData()
//        }
//        
//        presenter?.getProducts(
//            categoryId: categoryId,
//            page: currentPage
//        )
    }
    
    func setProducts(data: [ProductResult]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if data.isEmpty && self.products.isEmpty {
                self.emptyProducts = ["emptyProducts"]
                self.reloadData()
                self.collectionView.reloadData()
                self.collectionView.scrollToBottom(animated: true)
            }
            
            guard !data.isEmpty else { return }
            self.products += data
            self.emptyProducts = []
            self.isPaging = true
            self.currentPage += 1
            self.reloadData()
            self.collectionView.isHidden = false
            self.searchView.isHidden = false
            self.loaderView.isHidden = true
            self.errorView.isHidden = true
            self.loaderView.stop()
            self.collectionView.reloadData()
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
    
    func showError(data: String) {
        collectionView.isHidden = true
        searchView.isHidden = true
        errorView.isHidden = false
        loaderView.isHidden = true
        
        errorView.setupCell(errorName: data)
        errorView.actionHandler = { [weak self] in
            self?.getRequests()
        }
    }
    
    func showToastError(text: String) {
        toastAnimation(text: text) {}
    }
}
