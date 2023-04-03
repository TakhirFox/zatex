//
//  DetailViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 03/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    var presenter: DetailPresenterProtocol? { get set }
    
    func setProductInfo(data: ProductResult)
    func setSimilarProducts(data: ProductResult)
    func setStoreInfo(data: StoreInfoResult)
}

class DetailViewController: BaseViewController {
    
    enum RowKind: Int {
        case images, productInfo, mapShop, buttons, descriptions, author, similarProduct
    }
    
    var presenter: DetailPresenterProtocol?
    
    var product: ProductResult?
    var similarProducts: [ProductResult] = []
    var storeInfo: StoreInfoResult?
    
    var collectionView: UICollectionView!
    let headerView = ShopHeaderView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.getProductInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupSubviews()
        setupConstraints()
    }
    
    func setupCollectionView() {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImagesProductCell.self, forCellWithReuseIdentifier: "imagesCell")
        collectionView.register(InfoProductCell.self, forCellWithReuseIdentifier: "infoCell")
        collectionView.register(MapProductCell.self, forCellWithReuseIdentifier: "mapCell")
        collectionView.register(ContactProductCell.self, forCellWithReuseIdentifier: "buttonsCell")
        collectionView.register(DescriptionProductCell.self, forCellWithReuseIdentifier: "descCell")
        collectionView.register(AuthorProdCell.self, forCellWithReuseIdentifier: "authorCell")
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "similarCell")
    }
    
    func setupSubviews() {
        view.addSubview(collectionView)
        view.addSubview(headerView)
    }
    
    func setupConstraints() {
        collectionView.contentInset = UIEdgeInsets(top: 280, left: 16, bottom: 16, right: 16)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        let rows = RowKind(rawValue: section)
        switch rows {
        case .images:
            return 1
            
        case .productInfo:
            return 1
            
        case .mapShop:
            return 1
            
        case .buttons:
            return 1
            
        case .descriptions:
            return 1
            
        case .author:
            return 1
            
        case .similarProduct:
            return similarProducts.count
            
        case .none:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let rows = RowKind(rawValue: indexPath.section)
        switch rows {
        case .images:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagesCell", for: indexPath) as! ImagesProductCell
            cell.setupCell(images: product?.images)
            return cell
            
        case .productInfo:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infoCell", for: indexPath) as! InfoProductCell
            cell.setupCell(name: product?.name,
                           cost: product?.price)
            return cell
            
        case .mapShop:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mapCell", for: indexPath) as! MapProductCell
            cell.setupCell(map: product?.store?.address)
            return cell
            
        case .buttons:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buttonsCell", for: indexPath) as! ContactProductCell
            cell.setupCell()
            cell.messageButton.addTarget(self, action: #selector(goToChat), for: .touchUpInside)
            cell.callButton.addTarget(self, action: #selector(callPhone), for: .touchUpInside)
            return cell
            
        case .descriptions:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "descCell", for: indexPath) as! DescriptionProductCell
            cell.setupCell(description: product?.description ?? "")
            return cell
            
        case .author:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "authorCell", for: indexPath) as! AuthorProdCell
            cell.setupCell(author: storeInfo)
            return cell
            
        case .similarProduct:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "similarCell", for: indexPath) as! ProductCell
            cell.setupCell(similarProducts[indexPath.row])
            return cell
            
        case .none:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let rows = RowKind(rawValue: indexPath.section)
        switch rows {
        case .images:
            return .init(width: view.frame.width, height: 280)
            
        case .productInfo:
            return .init(width: view.frame.width, height: 80)
            
        case .mapShop:
            return .init(width: view.frame.width, height: 100)
            
        case .buttons:
            return .init(width: view.frame.width, height: 50)
            
        case .descriptions:
            return .init(width: view.frame.width, height: 130)
            
        case .author:
            return .init(width: view.frame.width, height: 150)
            
        case .similarProduct:
            return .init(width: view.frame.width / 2 - 24, height: 200)
            
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
        case .images:
            break
            
        case .productInfo,
                .descriptions,
                .author,
                .buttons:
            break
            
        case .mapShop:
            presenter?.goToMapScreen(
                coordinates: CoordinareEntity(
                    latitude: 55.018803, // TODO: Added dynamic data
                    longitude: 82.933952
                )
            )

        case .similarProduct:
            presenter?.goToDetail(id: similarProducts[indexPath.row].id ?? 0)
            
        case .none:
            break
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = -scrollView.contentOffset.y
        let maxHeight = max(offsetY, 100)
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: maxHeight)
        
        let pointInfo = -(-scrollView.contentOffset.y - scrollView.contentInset.top) / 1.3
        let centerInfo = (view.frame.width / 2) - (headerView.backView.frame.width / 2)
        let fromLeadingToCenterInfo = min(max(pointInfo, 16), centerInfo)
        
        headerView.backView.snp.updateConstraints { make in
            make.leading.equalToSuperview().inset(fromLeadingToCenterInfo)
        }
    }
}

extension DetailViewController {
    
    @objc private func goToChat() {
        if let productId = product?.id,
           let authorId = product?.store?.id {
            presenter?.checkChatExists(
                productAuthor: String(authorId),
                productId: String(productId))
        }
    }
    
    @objc private func callPhone() {
        presenter?.callPhone(number: storeInfo?.phone)
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    
    func setProductInfo(data: ProductResult) {
        DispatchQueue.main.async { [weak self] in
            self?.product = data
            
            if let storeId = data.store?.id {
                self?.presenter?.getStoreInfo(authorId: storeId)
            }
            
            self?.collectionView.reloadData()
        }
    }
    
    func setSimilarProducts(data: ProductResult) {
        DispatchQueue.main.async { [weak self] in
            self?.similarProducts.append(data)
            self?.collectionView.reloadData()
        }
    }
    
    func setStoreInfo(data: StoreInfoResult) {
        DispatchQueue.main.async { [weak self] in
            self?.headerView.setupCell(author: data)
            self?.storeInfo = data
            self?.collectionView.reloadData()
        }
    }
}
