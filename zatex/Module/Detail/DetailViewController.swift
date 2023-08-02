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
    func showSuccessReview()
    func showReviewButton(data: CheckChatReviewResult)
    func showError(data: String)
    func showToastError(text: String, type: ToastErrorKind)
    func showMapError(text: String)
}

class DetailViewController: BaseViewController {
    
    enum RowKind: Int {
        case images, productInfo, mapShop, contact, review, descriptions, author, similarProduct
    }
    
    var presenter: DetailPresenterProtocol?
    
    var sessionProvider: SessionProvider?
    var product: ProductResult?
    var similarProducts: [ProductResult] = []
    var storeInfo: StoreInfoResult?
    var reviewContent: String?
    var isShowReviewButton: Bool = false
    
    var collectionView: UICollectionView!
    let headerView = ShopHeaderView()
    let reviewDetailView = ReviewDetailView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getRequests()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationView()
        setupCollectionView()
        setupReviewDetailView()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupNavigationView() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    private func setupReviewDetailView() {
        reviewDetailView.isHidden = true
        reviewDetailView.textView.delegate = self
        reviewDetailView.sendReviewButton.addTarget(self, action: #selector(sendReview), for: .touchUpInside)
        reviewDetailView.setupCell()
    }
    
    private func setupCollectionView() {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImagesProductCell.self, forCellWithReuseIdentifier: "imagesCell")
        collectionView.register(InfoProductCell.self, forCellWithReuseIdentifier: "infoCell")
        collectionView.register(MapProductCell.self, forCellWithReuseIdentifier: "mapCell")
        collectionView.register(ContactProductCell.self, forCellWithReuseIdentifier: "buttonsCell")
        collectionView.register(ReviewProductCell.self, forCellWithReuseIdentifier: "reviewCell")
        collectionView.register(DescriptionProductCell.self, forCellWithReuseIdentifier: "descCell")
        collectionView.register(AuthorProdCell.self, forCellWithReuseIdentifier: "authorCell")
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "similarCell")
    }
    
    private func setupSubviews() {
        view.addSubview(collectionView)
        view.addSubview(headerView)
        view.addSubview(reviewDetailView)
    }
    
    private func setupConstraints() {
        collectionView.contentInset = UIEdgeInsets(top: 280, left: 16, bottom: 16, right: 16)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        reviewDetailView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func getRequests() {
        presenter?.getProductInfo()
        
        collectionView.isHidden = true
        headerView.isHidden = true
        errorView.isHidden = true
        loaderView.isHidden = false
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 8
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
            
        case .contact:
            let storeId = String(product?.store?.id ?? 0)
            
            if sessionProvider != nil,
               sessionProvider!.isAuthorized,
               storeId != sessionProvider!.getSession()?.userId
            {
                return 1
            }
            
            return 0
            
        case .review:
            return isShowReviewButton ? 1 : 0
            
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
            cell.onSignal = { signal in
                switch signal {
                case let .onOpenImage(id):
                    self.presenter?.goToFullscreen(images: self.product?.images, selected: id)
                }
            }
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
            
        case .contact:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buttonsCell", for: indexPath) as! ContactProductCell
            cell.setupCell()
            cell.messageButton.addTarget(self, action: #selector(goToChat), for: .touchUpInside)
            cell.callButton.addTarget(self, action: #selector(callPhone), for: .touchUpInside)
            return cell
            
        case .review:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewProductCell
            cell.setupCell()
            cell.reviewButton.addTarget(self, action: #selector(showReviewDialog), for: .touchUpInside)
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
            
        case .contact:
            return .init(width: view.frame.width, height: 50)
            
        case .review:
            return .init(width: view.frame.width, height: 50)
            
        case .descriptions:
            return .init(
                width: view.frame.width,
                height: (product?.description ?? "").heightForLabel(
                    font: UIFont(name: "Montserrat-Regular", size: 14)!,
                    width: view.frame.width - 32
                ) + 30
            )
            
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
                .contact,
                .review:
            break
            
        case .mapShop:
            presenter?.getCoordinatesAndGoToMap(address: product?.store?.address)
            
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

extension DetailViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text != nil {
            reviewContent = textView.text
        }
    }
    
}

extension DetailViewController {
    
    @objc private func goToChat() {
        if let productId = product?.id,
           let authorId = product?.store?.id {
            presenter?.checkChatExists(
                productAuthor: authorId,
                productId: productId)
        }
    }
    
    @objc private func callPhone() {
        presenter?.callPhone(number: storeInfo?.phone)
    }
    
    @objc private func showReviewDialog() {
        reviewDetailView.isHidden = false
    }
    
    @objc private func sendReview() {
        presenter?.sendReview(
            userId: product?.store?.id,
            productName: product?.name,
            content: reviewContent,
            rating: reviewDetailView.selectedRating
        )
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    
    func setProductInfo(data: ProductResult) {
        DispatchQueue.main.async { [weak self] in
            self?.product = data
            
            if let storeId = data.store?.id {
                self?.presenter?.getStoreInfo(authorId: storeId)
            }
            
            if let productId = self?.product?.id,
               let authorId = self?.product?.store?.id {
                self?.presenter?.checkStartChat(
                    productAuthor: productId,
                    productId: authorId
                )
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
            self?.collectionView.isHidden = false
            self?.headerView.isHidden = false
            self?.loaderView.isHidden = true
            self?.loaderView.stop()
            self?.collectionView.reloadData()
        }
    }
    
    func showSuccessReview() {
        DispatchQueue.main.async { [weak self] in
            self?.reviewDetailView.isHidden = true
        }
    }
    
    func showReviewButton(data: CheckChatReviewResult) {
        DispatchQueue.main.async { [weak self] in
            self?.isShowReviewButton = data.success ?? false
        }
    }
    
    func showError(data: String) {
        collectionView.isHidden = true
        headerView.isHidden = true
        errorView.isHidden = false
        loaderView.isHidden = true
        
        errorView.setupCell(errorName: data)
        errorView.actionHandler = { [weak self] in
            self?.getRequests()
        }
    }
    
    func showToastError(text: String, type: ToastErrorKind) {
        toastAnimation(text: text) { [weak self] in
            switch type {
            case .checkChatExists:
                if let productId = self?.product?.id,
                   let authorId = self?.product?.store?.id {
                    self?.presenter?.checkChatExists(
                        productAuthor: authorId,
                        productId: productId)
                }
                
            case .checkStartChat:
                if let productId = self?.product?.id,
                   let authorId = self?.product?.store?.id {
                    self?.presenter?.checkStartChat(
                        productAuthor: productId,
                        productId: authorId
                    )
                }
                
            case .sendReview:
                self?.presenter?.sendReview(
                    userId: self?.product?.store?.id,
                    productName: self?.product?.name,
                    content: self?.reviewContent,
                    rating: self?.reviewDetailView.selectedRating
                )
            }
        }
    }
    
    func showMapError(text: String) {
        debugPrint("LOG: Что-то") // TODO: Решить в задаче с картами
    }
}
