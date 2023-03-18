//
//  AuthorProdCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.11.2022.
//

import UIKit

class AuthorProdCell: UITableViewCell {
    
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let avatarView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 40
        view.layer.masksToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        return view
    }()
    
    private let ratingView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
                
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(author: StoreInfoResult?) {
        let avatarUrl = URL(string: author?.gravatar ?? "")
        
        avatarView.kf.setImage(with: avatarUrl)
        titleLabel.text = author?.storeName ?? ""
        ratingView.image = UIImage(named: "rat0")
        
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
    }
    
    private func configureSubviews() {
        addSubview(backView)
        backView.addSubview(avatarView)
        backView.addSubview(titleLabel)
        backView.addSubview(ratingView)
    }
    
    private func configureConstraints() {
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }
        
        avatarView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.avatarView.snp.trailing).offset(10)
        }
        
        ratingView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().inset(18)
            make.leading.equalTo(self.avatarView.snp.trailing).offset(10)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
