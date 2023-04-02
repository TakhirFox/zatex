//
//  ReviewsHeaderCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 20.03.2023.
//

import UIKit
import SnapKit

class ReviewsHeaderCell: UITableViewCell {
    
    private let storeNameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-SemiBold", size: 40)
        view.textAlignment = .center
        view.numberOfLines = 1
        return view
    }()
    
    private let ratingImageView: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let ratingNumberLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-SemiBold", size: 40)
        view.textAlignment = .center
        view.numberOfLines = 1
        return view
    }()
    
    private let ratingCountLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        view.textAlignment = .center
        view.numberOfLines = 1
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(store: StoreInfoResult?) {
        storeNameLabel.text = store?.storeName ?? ""
        ratingNumberLabel.text = store?.rating?.rating ?? ""
        ratingCountLabel.text = "\(store?.rating?.count ?? 0) отзывов"
        ratingImageView.image = UIImage(named: "star0")
        
        if let rating = store?.rating?.rating {
            if store?.rating?.count != 0 {
                let intValue = Double(rating) ?? 0
                let roundRating = round(intValue) // TODO: Везде применит округление
                let ratingStar = "star\(roundRating)"
                ratingImageView.image = UIImage(named: ratingStar)
            }
        }
    }
    
    private func configureSubviews() {
        addSubview(storeNameLabel)
        addSubview(ratingImageView)
        addSubview(ratingNumberLabel)
        addSubview(ratingCountLabel)
    }
    
    private func configureConstraints() {
        storeNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        ratingImageView.snp.makeConstraints { make in
            make.top.equalTo(storeNameLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(55)
        }
        
        ratingNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingImageView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(55)
        }
        
        ratingCountLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingNumberLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    private func updateAppearence() {
        backgroundColor = .clear
        selectionStyle = .none
        
        storeNameLabel.textColor = Palette.Text.primary
        ratingNumberLabel.textColor = Palette.Text.primary
        ratingCountLabel.textColor = Palette.Text.primary
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
