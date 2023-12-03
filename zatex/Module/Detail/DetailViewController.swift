//
//  DetailViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 03/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit
import Kingfisher

protocol DetailViewControllerProtocol: AnyObject {
    var presenter: DetailPresenterProtocol? { get set }
    
    func setProductInfo(data: ProductResult)
    func setSimilarProducts(data: [ProductResult])
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
    
    private var product: ProductResult?
    private var similarProducts: [ProductResult] = []
    private var storeInfo: StoreInfoResult?
    private var reviewContent: String?
    private var isShowReviewButton: Bool = false
    
    private var collectionView: UICollectionView!
    private var settingsButton = UIButton()
    private var favoriteButton = UIButton()
    private let headerView = ShopHeaderView()
    private let reviewDetailView = ReviewDetailView()
    private let successReviewDetailView = SuccessReviewDetailView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getRequests()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupReviewDetailView()
        setupSuccessReviewDetailView()
        setupSubviews()
        setupConstraints()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.setupNavigationItem()
            self?.setupNavigationView()
        }
    }
    
    private func setupNavigationView() {
        var backImage = UIImage(named: "BackIcon")
        
        switch Appearance.shared.theme.value {
        case .dark:
            backImage = UIImage(named: "DarkBackIcon")
            
        case .light:
            backImage = UIImage(named: "BackIcon")
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    private func setupNavigationItem() {
        let isFavorite = product?.isFavorite ?? false
        
        switch Appearance.shared.theme.value {
        case .dark:
            let image = isFavorite ? UIImage(named: "dark-like-fill") : UIImage(named: "dark-like-unfill")
            favoriteButton.setImage(image, for: .normal)
            
        case .light:
            let image = isFavorite ? UIImage(named: "light-like-fill") : UIImage(named: "light-like-unfill")
            favoriteButton.setImage(image, for: .normal)
        }
        
        settingsButton.setImage(UIImage(named: "share-icon-dark"), for: .normal)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.addTarget(self, action: #selector(sharePageAction), for: .touchUpInside)
        let settingsItem = UIBarButtonItem(customView: settingsButton)
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.addTarget(self, action: #selector(changeFavoriteAction), for: .touchUpInside)
        let favoriteItem = UIBarButtonItem(customView: favoriteButton)
        
        navigationItem.rightBarButtonItems = [settingsItem, favoriteItem]
    }
    
    private func setupReviewDetailView() {
        reviewDetailView.isHidden = true
        reviewDetailView.textView.delegate = self
        reviewDetailView.sendReviewButton.addTarget(self, action: #selector(sendReview), for: .touchUpInside)
        reviewDetailView.setupCell()
    }
    
    private func setupSuccessReviewDetailView() {
        successReviewDetailView.isHidden = true
        successReviewDetailView.okButton.addTarget(self, action: #selector(closeSuccessView), for: .touchUpInside)
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
        view.addSubview(successReviewDetailView)
    }
    
    private func setupConstraints() {
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
        
        successReviewDetailView.snp.makeConstraints { make in
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
        loaderView.play()
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 8
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
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
            guard let isShop = storeInfo?.isShop else { return 0 }
            return isShop ? 0 : 1
            
        case .similarProduct:
            return similarProducts.count
            
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
            
            cell.onSignal = { [weak self] signal in
                guard let productId = self?.similarProducts[indexPath.row].id else { return }
                
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
            return .init(width: view.frame.width, height: 100)
            
        case .similarProduct:
            return .init(width: view.frame.width / 2 - 24, height: 200)
            
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
        case .images:
            break
            
        case .productInfo,
                .descriptions:
            break
            
        case .author:
            guard let userId = storeInfo?.id else { return }
            presenter?.goToProfile(id: userId)
            
        case .contact,
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
        
        headerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToProfile)))
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
    
    @objc private func sharePageAction() {
        guard let productId = product?.id,
              let name = product?.name else { return }
        
        let text = "Посмотри товар \(name)"
        let url = URL(string: "zatexmobile://product?productID=\(productId)")!
        var shareAll: [Any] = [text, url]
        
        if let imageUrl = product?.images?.first?.src {
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
    
    @objc private func changeFavoriteAction() {
        guard let isFavorite = product?.isFavorite,
        let productId = product?.id else { return }
        
        if isFavorite {
            presenter?.removeFavorite(productId: productId)
            product?.isFavorite = false
        } else {
            presenter?.addFavorite(productId: productId)
            product?.isFavorite = true
        }
        
        setupNavigationItem()
    }
    
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
    
    @objc private func closeSuccessView() {
        successReviewDetailView.isHidden = true
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
        
        showLoader(enable: true)
    }
    
    @objc private func goToProfile() {
        guard let userId = storeInfo?.id else { return }
        presenter?.goToProfile(id: userId)
    }
    
    private func showLoader(enable: Bool) {
        reviewDetailView.startLoad(enable: enable)
        
        collectionView.alpha = enable ? 0.5 : 1
        collectionView.isUserInteractionEnabled = !enable
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
            
            self?.setupNavigationItem()
            self?.collectionView.reloadData()
        }
    }
    
    func setSimilarProducts(data: [ProductResult]) {
        DispatchQueue.main.async { [weak self] in
            self?.similarProducts = data
            self?.collectionView.reloadData()
        }
    }
    
    func setStoreInfo(data: StoreInfoResult) {
        DispatchQueue.main.async { [weak self] in
            let isPersonShop = !(data.isShop ?? true)
            
            self?.collectionView.contentInset = UIEdgeInsets(
                top: isPersonShop ? 0 : 280,
                left: 16,
                bottom: 16,
                right: 16
            )
            
            self?.headerView.setupCell(author: data)
            self?.storeInfo = data
            self?.collectionView.isHidden = false
            self?.headerView.isHidden = isPersonShop
            self?.loaderView.isHidden = true
            self?.loaderView.stop()
            self?.collectionView.reloadData()
        }
    }
    
    func showSuccessReview() {
        DispatchQueue.main.async { [weak self] in
            self?.reviewDetailView.isHidden = true
            self?.successReviewDetailView.isHidden = false
        }
        
        showLoader(enable: false)
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
                
            case .addFavorite:
                break
                
            case .removeFvorite:
                break
            }
        }
    }
    
    func showMapError(text: String) {
        debugPrint("LOG: Что-то") // TODO: Решить в задаче с картами
    }
}
