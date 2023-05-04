//
//  ReviewProductCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 28.04.2023.
//

import UIKit

class ReviewProductCell: UICollectionViewCell {
    
    let reviewButton: BaseButton = {
        let view = BaseButton()
        view.set(style: .sedondary)
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
    
    func setupCell() {
        reviewButton.setTitle("Оставить отзыв", for: .normal)
    }
    
    private func updateAppearence() {}
    
    private func configureSubviews() {
        contentView.addSubview(reviewButton)
    }
    
    private func configureConstraints() {
        reviewButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
