//
//  ShopHeaderView.swift
//  zatex
//
//  Created by Zakirov Tahir on 07.11.2022.
//

import UIKit

class ShopHeaderView: UIView {
    
    private let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let avatarView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-SemiBold", size: 20)
        return view
    }()
    
    private let ratingView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let backView: UIView = {
        let view = UIView()
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
        let avatarUrl = URL(string: author?.gravatar ?? "")
        
        avatarView.kf.setImage(with: avatarUrl)
        backgroundImageView.image = UIImage(named: "defaultBanner")
        titleLabel.text = author?.storeName ?? ""
        ratingView.image = UIImage(named: "rat0")

        if author?.banner != nil, !(author?.banner!.isEmpty)! {
            let banner = (author?.banner?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            let bannerUrl = URL(string: banner)
            
            backgroundImageView.kf.setImage(with: bannerUrl)
        }
        
        if let rating = author?.rating?.rating {
            if author?.rating?.count != 0 {
                let ratingStar = "rat\(rating)"
                ratingView.image = UIImage(named: ratingStar)
            }
        }
    }
    
    private func updateAppearence() {
        titleLabel.textColor = Palette.Text.primary
    }
    
    private func configureSubviews() {
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(backView)
        backView.addSubview(avatarView)
        backView.addSubview(titleLabel)
        backView.addSubview(ratingView)
    }
    
    private func configureConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
                
        backView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(12)
            make.leading.equalToSuperview().offset(16)
        }
        
        avatarView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4)
            make.leading.equalTo(self.avatarView.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
        }

        ratingView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(self.avatarView.snp.trailing).offset(10)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
