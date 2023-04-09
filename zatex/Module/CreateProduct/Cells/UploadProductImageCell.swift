//
//  UploadProductImageCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 09.04.2023.
//

import UIKit

class UploadProductImageCell: UICollectionViewCell {
    
    private let productImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(image: UIImage) {
        productImageView.image = image
    }
    
    private func configureView() {
        backgroundColor = .clear
        contentView.isUserInteractionEnabled = false
        
//        spinner.startAnimating() // TODO: Для индикации загрузки
//        productImageView.alpha = 0.5
    }
    
    private func updateAppearence() {}
    
    private func configureSubviews() {
        addSubview(productImageView)
        addSubview(spinner)
    }
    
    private func configureConstraints() {
        spinner.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        productImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
