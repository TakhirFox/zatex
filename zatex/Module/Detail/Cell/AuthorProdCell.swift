//
//  AuthorProdCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.11.2022.
//

import UIKit

class AuthorProdCell: UICollectionViewCell {
    
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let horizontalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        return view
    }()
    
    private let verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .leading
        return view
    }()
    
    private let avatarView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        return view
    }()
    
    private let shopModeLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-SemiBold", size: 13)
        return view
    }()
    
    private let ratingView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
                
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(author: StoreInfoResult?) {
        let firstName = author?.firstName ?? ""
        let lastName = author?.lastName ?? ""
        
        avatarView.image = UIImage(named: "no-avatar")
        titleLabel.text = "\(firstName) \(lastName)"
        ratingView.image = UIImage(named: "rat0")
        shopModeLabel.text = "Частный магазин"
        
        switch author?.gravatar {
        case .avatar(let avatar):
            if !(avatar.isEmpty) {
                let avatarUrl = URL(string: avatar)
                avatarView.kf.setImage(with: avatarUrl)
            }
            
        case .empty, nil:
            return
        }
        
        if let rating = author?.rating?.rating {
            if author?.rating?.count != 0 {
                let ratingStar = "rat\(rating)"
                ratingView.image = UIImage(named: ratingStar)
            }
        }
    }
    
    private func updateAppearence() {
        backView.backgroundColor = Palette.Background.secondary
        titleLabel.textColor = Palette.Text.primary
        shopModeLabel.textColor = Palette.AccentText.secondary
    }
    
    private func configureSubviews() {
        addSubview(backView)
        backView.addSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(avatarView)
        horizontalStackView.addArrangedSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(shopModeLabel)
        verticalStackView.addArrangedSubview(ratingView)
    }
    
    private func configureConstraints() {
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        
        horizontalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        avatarView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
