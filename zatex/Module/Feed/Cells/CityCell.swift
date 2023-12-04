//
//  CityCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 04.12.2023.
//

import UIKit

class CityCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        return view
    }()
    
    private let cityNameLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-SemiBold", size: 16)
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
    
    func setupCell(title: String, city: String) {
        titleLabel.text = title
        cityNameLabel.text = city
    }
    
    private func updateAppearence() {
        titleLabel.textColor = Palette.Text.primary
        cityNameLabel.textColor = Palette.Text.primary
        
        switch Appearance.shared.theme.value {
        case .dark:
            imageView.image = UIImage(named: "dark-geo")
            
        case .light:
            imageView.image = UIImage(named: "light-geo")
        }
    }
    
    private func configureSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(cityNameLabel)
    }
    
    private func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.bottom.equalToSuperview()
        }
        
        cityNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalTo(titleLabel.snp.trailing).offset(16)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
