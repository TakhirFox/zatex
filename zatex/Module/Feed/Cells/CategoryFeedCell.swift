//
//  CategoryFeedCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 17.10.2022.
//

import UIKit

class CategoryFeedCell: UICollectionViewCell {

    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-Medium", size: 14)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = self.frame.height / 2
        
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

    }
    
    private func updateAppearence() {
        self.backgroundColor = Palette.AccentText.primary
        titleLabel.textColor = Palette.Background.tertiary
    }
    
    private func configureSubviews() {
        addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
