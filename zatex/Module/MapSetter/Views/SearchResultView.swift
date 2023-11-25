//
//  SearchResultView.swift
//  zatex
//
//  Created by Zakirov Tahir on 29.07.2023.
//

import UIKit
import Lottie

class SearchResultView: UIView {
    
    var tappedHandler: ((CoordinatesResult) -> Void)?
    
    private let contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private let tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    private var loaderView = LottieAnimationView(name: "loader")
    
    private var addressResult: [CoordinatesResult] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubviews()
        configureConstraints()
        updateAppearence()
        setupTableView()
        setLoader()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(address: [CoordinatesResult]) {
        DispatchQueue.main.async { [weak self] in
            self?.addressResult = address
            self?.tableView.reloadData()
        }
    }
    
    func loader(isShow: Bool) {
        if isShow {
            loaderView.play()
            loaderView.isHidden = false
        } else {
            loaderView.stop()
            loaderView.isHidden = true
        }
    }
    
    private func updateAppearence() {
        contentView.backgroundColor = Palette.Background.secondary
    }
    
    private func configureSubviews() {
        addSubview(contentView)
        contentView.addSubview(tableView)
    }
    
    private func configureConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(200)
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setLoader() {
        loaderView.contentMode = .scaleAspectFill
        loaderView.loopMode = .loop
        loaderView.animationSpeed = 2
        loaderView.isHidden = true
        loaderView.stop()
        
        addSubview(loaderView)
        
        loaderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }
    
    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchResultView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let city = addressResult[indexPath.row].address?.city ?? ""
        let road = addressResult[indexPath.row].address?.road ?? ""
        let houseNumber = addressResult[indexPath.row].address?.houseNumber ?? ""
        
        cell.textLabel?.text = "\(city), \(road) \(houseNumber)"
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tappedHandler?(addressResult[indexPath.row])
    }
}
