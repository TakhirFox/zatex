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
    
    let removeButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "xmark.circle.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .normal)
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
    
    func setupCell(image: ProductEntity.Image) {
        
        productImageView.image = image.image
    }
    
    private func configureView() {
        backgroundColor = .clear
        contentView.isUserInteractionEnabled = false
    }
    
    private func updateAppearence() {}
    
    private func configureSubviews() {
        addSubview(productImageView)
        addSubview(removeButton)
    }
    
    private func configureConstraints() {
        productImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        removeButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
