//
//  CategoryFeedCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 17.10.2022.
//

import UIKit

class CategoryFeedCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 0
        view.font = UIFont(name: "Montserrat-Medium", size: 12)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 8
        
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(_ category: CategoryResult) {
        titleLabel.text = category.name
        
        if category.selected == true {
            self.backgroundColor = Palette.Background.tertiary
            titleLabel.textColor = Palette.AccentText.primary
        } else {
            self.backgroundColor = Palette.AccentText.primary
            titleLabel.textColor = Palette.Background.tertiary
        }
        
        if let imageUrl = category.description {
            let url = (imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            let urlString = URL(string: url)
            imageView.kf.setImage(with: urlString)
        }
    }
    
    private func updateAppearence() {
        self.backgroundColor = Palette.AccentText.primary
        titleLabel.textColor = Palette.Background.tertiary
    }
    
    private func configureSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
            
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.height.equalTo(35)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
