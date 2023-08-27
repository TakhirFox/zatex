//
//  UserProfileLoaderCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 28.08.2023.
//

import UIKit
import Lottie

class UserProfileLoaderCell: UICollectionViewCell {
    
    private let loaderView = LottieAnimationView(name: "loader")
    
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
    
    func setupCell() {
        loaderView.play()
        loaderView.animationSpeed = 2
    }
    
    private func updateAppearence() {}
    
    private func configureSubviews() {
        addSubview(loaderView)
    }
    
    private func configureConstraints() {
        loaderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
