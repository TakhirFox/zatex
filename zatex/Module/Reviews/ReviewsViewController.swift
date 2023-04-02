//
//  ReviewsReviewsViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 20/03/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol ReviewsViewControllerProtocol: AnyObject {
    var presenter: ReviewsPresenterProtocol? { get set }

    func setReviews(data: [ReviewsListResult])
    func setStoreInfo(data: StoreInfoResult)
}

class ReviewsViewController: BaseViewController {
    
    enum SectionType: Int {
        case header, main
    }
    
    var presenter: ReviewsPresenterProtocol?
    
    var reviewStoreInfo: StoreInfoResult?
    var reviewList: [ReviewsListResult]?
    
    let tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.getReviews()
        presenter?.getStoreInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupTableView() {
        tableView.register(ReviewsHeaderCell.self, forCellReuseIdentifier: "headerCell")
        tableView.register(ReviewsCell.self, forCellReuseIdentifier: "reviewsCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
}

extension ReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        let sections = SectionType(rawValue: section)
        
        switch sections {
        case .header:
            return 1
        case .main:
            return reviewList?.count ?? 0
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sections = SectionType(rawValue: indexPath.section)
        
        switch sections {
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! ReviewsHeaderCell
            cell.setupCell(store: reviewStoreInfo)
            return cell
        case .main:
            let cell = tableView.dequeueReusableCell(withIdentifier: "reviewsCell", for: indexPath) as! ReviewsCell
            cell.setupCell(reviews: reviewList?[indexPath.row])
            return cell
        case .none:
            return UITableViewCell()
        }
    }
}

extension ReviewsViewController: ReviewsViewControllerProtocol {
   
    func setReviews(data: [ReviewsListResult]) {
        print("LOG: setReviews \(data)")
        
        DispatchQueue.main.async { [weak self] in
            self?.reviewList = data
            self?.tableView.reloadData()
        }
    }
    
    func setStoreInfo(data: StoreInfoResult) {
        print("LOG: setStoreInfo \(data)")
        
        DispatchQueue.main.async { [weak self] in
            self?.reviewStoreInfo = data
            self?.tableView.reloadData()
        }
    }
}
