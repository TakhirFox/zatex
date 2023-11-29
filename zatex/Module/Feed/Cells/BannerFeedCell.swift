//
//  BannerFeedCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 17.10.2022.
//

import UIKit
import Kingfisher

class BannerFeedCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Баннер"
        view.textAlignment = .center
        view.font = UIFont(name: "Montserrat-SemiBold", size: 13)
        view.numberOfLines = 1
        return view
    }()
    
    private let subtitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Баннер"
        view.textAlignment = .center
        view.font = UIFont(name: "Montserrat-Medium", size: 11)
        view.numberOfLines = 1
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }

    
    func setupCell(_ item: BannerResult) {
        titleLabel.text = item.title
        subtitleLabel.text = item.secondDesc
        
        let url = URL(string: item.imageBanner)
        
        imageView.kf.setImage(with: url)
    }
    
    private func updateAppearence() {
        backView.backgroundColor = Palette.Background.tertiary
        titleLabel.textColor = Palette.AccentText.primary
        subtitleLabel.textColor = Palette.AccentText.primary
    }
    
    private func configureSubviews() {
        addSubview(imageView)
        addSubview(backView)
        backView.addSubview(titleLabel)
        backView.addSubview(subtitleLabel)
    }
    
    private func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        backView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(47)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(2)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).inset(4)
            make.leading.trailing.bottom.equalToSuperview().inset(2)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
