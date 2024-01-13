//
//  InfoProductCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.11.2022.
//

import UIKit

class InfoProductCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        return view
    }()
    
    private let costLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-Medium", size: 20)
        return view
    }()
    
    private let currencyLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-Medium", size: 20)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        contentView.isUserInteractionEnabled = false
        
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(
        name: String?,
        cost: String?,
        currency: String?
    ) {
        titleLabel.text = name ?? ""
        
        if cost != nil {
            costLabel.text = "\(cost!)"
        }
        
        if currency != nil {
            currencyLabel.text = "\(currency!)"
        }
    }
    
    private func updateAppearence() {
        titleLabel.textColor = Palette.Text.primary
        costLabel.textColor = Palette.Text.secondary
        currencyLabel.textColor = Palette.Text.secondary
    }
    
    private func configureSubviews() {
        addSubview(titleLabel)
        addSubview(costLabel)
        addSubview(currencyLabel)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.trailing.equalToSuperview().offset(16)
        }
        
        costLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(6)
        }
        
        currencyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.costLabel.snp.centerY)
            make.leading.equalTo(self.costLabel.snp.trailing).offset(4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
