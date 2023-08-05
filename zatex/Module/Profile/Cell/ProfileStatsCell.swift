//
//  ProfileStatsCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 10.11.2022.
//

import UIKit

class ProfileStatsCell: UICollectionViewCell {
    
    enum Signal {
        case stats
        case active
        case sales
    }
    
    var onSignal: (Signal) -> Void = { _ in }
    
    private let staticView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let sinceStoreView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let basicStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .center
        return view
    }()
    
    private let firstStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    private let secondStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    private let thirdStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    public let countRatingLabel: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        view.addTarget(self, action: #selector(openView), for: .touchUpInside)
        view.tag = 0
        return view
    }()
    
    public let nameRatingLabel: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        view.addTarget(self, action: #selector(openView), for: .touchUpInside)
        view.tag = 0
        return view
    }()
    
    private let countActiveLabel: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        view.addTarget(self, action: #selector(openView), for: .touchUpInside)
        view.tag = 1
        return view
    }()

    private let nameActiveLabel: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        view.addTarget(self, action: #selector(openView), for: .touchUpInside)
        view.tag = 1
        return view
    }()
    
    private let countSalesLabel: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        view.addTarget(self, action: #selector(openView), for: .touchUpInside)
        view.tag = 2
        return view
    }()

    private let nameSalesLabel: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        view.addTarget(self, action: #selector(openView), for: .touchUpInside)
        view.tag = 2
        return view
    }()
    
    private let sinceStoreLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-Medium", size: 12)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
                
        configureViews()
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(stats: StoreInfoResult?) {
        countRatingLabel.setTitle(String(stats?.rating?.count ?? 0), for: .normal)
        nameRatingLabel.setTitle("Отзывов", for: .normal)
        
        countActiveLabel.setTitle(String(stats?.rating?.count ?? 0), for: .normal)
        nameActiveLabel.setTitle("Активных", for: .normal)
        
        countSalesLabel.setTitle(String(stats?.rating?.count ?? 0), for: .normal)
        nameSalesLabel.setTitle("Продано", for: .normal)
        
        sinceStoreLabel.text = "На Затекс с \(dateFormatter(date: stats?.registered))"
    }
    
    private func updateAppearence() {
        staticView.backgroundColor = Palette.Background.secondary
        sinceStoreView.backgroundColor = Palette.Background.secondary
        sinceStoreLabel.textColor = Palette.Text.primary
        
        countRatingLabel.setTitleColor(Palette.Text.primary, for: .normal)
        nameRatingLabel.setTitleColor(Palette.AccentText.primary, for: .normal)
        
        countActiveLabel.setTitleColor(Palette.Text.primary, for: .normal)
        nameActiveLabel.setTitleColor(Palette.AccentText.primary, for: .normal)
        
        countSalesLabel.setTitleColor(Palette.Text.primary, for: .normal)
        nameSalesLabel.setTitleColor(Palette.AccentText.primary, for: .normal)
    }
    
    private func configureSubviews() {
        addSubview(staticView)
        staticView.addSubview(basicStackView)
        
        basicStackView.addArrangedSubview(firstStackView)
        firstStackView.addArrangedSubview(countRatingLabel)
        firstStackView.addArrangedSubview(nameRatingLabel)
        
        basicStackView.addArrangedSubview(secondStackView)
        secondStackView.addArrangedSubview(countActiveLabel)
        secondStackView.addArrangedSubview(nameActiveLabel)
        
        basicStackView.addArrangedSubview(thirdStackView)
        thirdStackView.addArrangedSubview(countSalesLabel)
        thirdStackView.addArrangedSubview(nameSalesLabel)
        
        addSubview(sinceStoreView)
        sinceStoreView.addSubview(sinceStoreLabel)
    }
    
    private func configureViews() {}
    
    private func configureConstraints() {
        staticView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(75)
        }
        
        countRatingLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        
        nameRatingLabel.snp.makeConstraints { make in
            make.height.equalTo(12)
        }
        
        countActiveLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        
        nameActiveLabel.snp.makeConstraints { make in
            make.height.equalTo(12)
        }
        
        countSalesLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        
        nameSalesLabel.snp.makeConstraints { make in
            make.height.equalTo(12)
        }
        
        basicStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        sinceStoreView.snp.makeConstraints { make in
            make.top.equalTo(staticView.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview()
        }
        
        sinceStoreLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func dateFormatter(date: String?) -> String {
        guard let date = date else { return ""}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        let newDate = dateFormatter.date(from: date) ?? Date()
        
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: newDate)
    }
    
    @objc private func openView(sender: UIButton) {
        switch sender.tag {
        case 0:
            onSignal(.stats)
            
        case 1:
            onSignal(.active)
            
        case 2:
            onSignal(.sales)
            
        default:
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
