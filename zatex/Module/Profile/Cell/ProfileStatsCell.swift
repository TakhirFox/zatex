//
//  ProfileStatsCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 10.11.2022.
//

import UIKit

class ProfileStatsCell: UITableViewCell {
    
    private let ratingView = UIView()
    private let ratingLabel = UILabel()
    private let ratingScoreLabel = UILabel()
    private let ratingTitleLabel = UILabel()
    
    private let createView = UIView()
    private let sinceLabel = UILabel()
    private let sinceMonthLabel = UILabel()
    private let sinceYearLabel = UILabel()
    
    private let activeProdView = UIView()
    private let countActiveLabel = UILabel()
    private let titleActiveLabel = UILabel()
    
    private let salesProdView = UIView()
    private let countSalesLabel = UILabel()
    private let titleSalesLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
                
        configureViews()
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(name: String) { // TODO: Изменить
        ratingLabel.text = "4.6"
        ratingScoreLabel.text = "1563"
        ratingTitleLabel.text = "Отзывов"
        
        sinceLabel.text = "Основан"
        sinceMonthLabel.text = "Ноябрь"
        sinceYearLabel.text = "2014"
        
        countActiveLabel.text = "25"
        titleActiveLabel.text = "Активно"
        
        countSalesLabel.text = "164"
        titleSalesLabel.text = "Продано"
    }
    
    private func updateAppearence() {
        ratingView.backgroundColor = Palette.Background.tertiary
        ratingLabel.textColor = Palette.AccentText.secondary
        ratingScoreLabel.textColor = Palette.AccentText.secondary
        ratingTitleLabel.textColor = Palette.AccentText.secondary
        
        createView.backgroundColor = Palette.Background.tertiary
        sinceLabel.textColor = Palette.AccentText.secondary
        sinceMonthLabel.textColor = Palette.AccentText.secondary
        sinceYearLabel.textColor = Palette.AccentText.secondary
        
        activeProdView.backgroundColor = Palette.Background.tertiary
        countActiveLabel.textColor = Palette.AccentText.secondary
        titleActiveLabel.textColor = Palette.AccentText.secondary
        
        salesProdView.backgroundColor = Palette.Background.tertiary
        countSalesLabel.textColor = Palette.AccentText.secondary
        titleSalesLabel.textColor = Palette.AccentText.secondary
    }
    
    private func configureSubviews() {
        addSubview(ratingView)
        ratingView.addSubview(ratingLabel)
        ratingView.addSubview(ratingScoreLabel)
        ratingView.addSubview(ratingTitleLabel)
        
        addSubview(createView)
        createView.addSubview(sinceLabel)
        createView.addSubview(sinceMonthLabel)
        createView.addSubview(sinceYearLabel)
        
        addSubview(activeProdView)
        activeProdView.addSubview(countActiveLabel)
        activeProdView.addSubview(titleActiveLabel)
        
        addSubview(salesProdView)
        salesProdView.addSubview(countSalesLabel)
        salesProdView.addSubview(titleSalesLabel)
    }
    
    private func configureViews() {
        // rating
        ratingView.layer.cornerRadius = 8
        
        ratingLabel.numberOfLines = 1
        ratingLabel.textAlignment = .center
        ratingLabel.font = UIFont(name: "Montserrat-SemiBold", size: 32)
        
        ratingScoreLabel.numberOfLines = 1
        ratingScoreLabel.textAlignment = .center
        ratingScoreLabel.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        
        ratingTitleLabel.numberOfLines = 1
        ratingTitleLabel.textAlignment = .center
        ratingTitleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 13)
        // since
        createView.layer.cornerRadius = 8
        
        sinceLabel.numberOfLines = 1
        sinceLabel.textAlignment = .center
        sinceLabel.font = UIFont(name: "Montserrat-SemiBold", size: 13)
        
        sinceMonthLabel.numberOfLines = 1
        sinceMonthLabel.textAlignment = .center
        sinceMonthLabel.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        
        sinceYearLabel.numberOfLines = 1
        sinceYearLabel.textAlignment = .center
        sinceYearLabel.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        // active
        activeProdView.layer.cornerRadius = 8
        
        countActiveLabel.numberOfLines = 1
        countActiveLabel.textAlignment = .center
        countActiveLabel.font = UIFont(name: "Montserrat-SemiBold", size: 32)
        
        titleActiveLabel.numberOfLines = 1
        titleActiveLabel.textAlignment = .center
        titleActiveLabel.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        // sales
        salesProdView.layer.cornerRadius = 8
        
        countSalesLabel.numberOfLines = 1
        countSalesLabel.textAlignment = .center
        countSalesLabel.font = UIFont(name: "Montserrat-SemiBold", size: 32)
        
        titleSalesLabel.numberOfLines = 1
        titleSalesLabel.textAlignment = .center
        titleSalesLabel.font = UIFont(name: "Montserrat-SemiBold", size: 12)

    }
    
    private func configureConstraints() {
        ratingView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(85)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10 )
            make.leading.trailing.equalToSuperview().inset(4)
            make.height.equalTo(32)
        }
        
        ratingScoreLabel.snp.makeConstraints { make in
            make.top.equalTo(self.ratingLabel.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(4)
            make.height.equalTo(16)
        }
        
        ratingTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.ratingScoreLabel.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(4)
            make.bottom.equalToSuperview().inset(10)
            make.height.equalTo(13)
        }
        
        
        createView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(self.ratingView.snp.trailing).offset(16)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(85)
        }
        
        sinceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10 )
            make.leading.trailing.equalToSuperview().inset(4)
            make.height.equalTo(13)
        }
        
        sinceMonthLabel.snp.makeConstraints { make in
            make.top.equalTo(self.sinceLabel.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(4)
            make.height.equalTo(16)
        }
        
        sinceYearLabel.snp.makeConstraints { make in
            make.top.equalTo(self.sinceMonthLabel.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(4)
            make.bottom.equalToSuperview().inset(10)
            make.height.equalTo(24)
        }
        
        
        activeProdView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(self.createView.snp.trailing).offset(16)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(85)
        }
        
        countActiveLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(4)
            make.height.equalTo(32)
        }
        
        
        titleActiveLabel.snp.makeConstraints { make in
            make.top.equalTo(self.countActiveLabel.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(4)
            make.bottom.equalToSuperview().inset(10)
            make.height.equalTo(12)
        }
        
        salesProdView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(self.activeProdView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(85)
        }
        
        countSalesLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(4)
            make.height.equalTo(32)
        }
        
        
        titleSalesLabel.snp.makeConstraints { make in
            make.top.equalTo(self.countSalesLabel.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(4)
            make.bottom.equalToSuperview().inset(10)
            make.height.equalTo(12)
        }
        

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
