//
//  ProductImageCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 16.03.2023.
//

import UIKit

class ProductImageCell: UICollectionViewCell {
    
    private let productImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let imageViewBackground: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private let loadButton: UIButton = {
        let view = UIButton()
        view.isHidden = true
        return view
    }()
    
    private let blurEffect = UIBlurEffect(style: .light)
    
    private var blurredEffectView: UIVisualEffectView = {
        let view = UIVisualEffectView()
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
    
    func setupCell(image: String?) {
        productImageView.image = UIImage(named: "no_images")
        
        if image != nil {
            let processedImage = (image?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            let urlString = URL(string: processedImage)
            productImageView.kf.setImage(with: urlString)
            imageViewBackground.kf.setImage(with: urlString)
        }
    }
    
    private func configureView() {
        backgroundColor = .clear
        contentView.isUserInteractionEnabled = false
        imageViewBackground.frame = bounds
        blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = imageViewBackground.bounds
    }
    
    private func updateAppearence() {}
    
    private func configureSubviews() {
        addSubview(imageViewBackground)
        addSubview(blurredEffectView)
        addSubview(productImageView)
        addSubview(loadButton)
    }
    
    private func configureConstraints() {
        loadButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        productImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        imageViewBackground.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
