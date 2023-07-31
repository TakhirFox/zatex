//
//  ProfileStatsCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 10.11.2022.
//

import UIKit

class ProfileStatsCell: UICollectionViewCell {
    
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
        return view
    }()

    public let nameRatingLabel: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        return view
    }()
    
    private let countActiveLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.textAlignment = .center
        view.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        return view
    }()

    private let nameActiveLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.textAlignment = .center
        view.font = UIFont(name: "Montserrat-Medium", size: 12)
        return view
    }()
    
    private let countSalesLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.textAlignment = .center
        view.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        return view
    }()

    private let nameSalesLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.textAlignment = .center
        view.font = UIFont(name: "Montserrat-Medium", size: 12)
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
        
        countActiveLabel.text = "16"
        nameActiveLabel.text = "Активных"
        
        countSalesLabel.text = "96"
        nameSalesLabel.text = "Продано"
        
        sinceStoreLabel.text = "На Затекс с \(dateFormatter(date: stats?.registered))"
    }
    
    private func updateAppearence() {
        staticView.backgroundColor = Palette.Background.secondary
        sinceStoreView.backgroundColor = Palette.Background.secondary
        sinceStoreLabel.textColor = Palette.Text.primary
        
        countRatingLabel.setTitleColor(Palette.Text.primary, for: .normal)
        nameRatingLabel.setTitleColor(Palette.AccentText.primary, for: .normal)
        
        countActiveLabel.textColor = Palette.Text.primary
        nameActiveLabel.textColor = Palette.AccentText.primary
        
        countSalesLabel.textColor = Palette.Text.primary
        nameSalesLabel.textColor = Palette.AccentText.primary
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
