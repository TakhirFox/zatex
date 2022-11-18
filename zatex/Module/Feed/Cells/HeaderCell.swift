//
//  HeaderCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 29.10.2022.
//

import UIKit

class HeaderCell: UICollectionReusableView {
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Баннер"
        view.font = UIFont(name: "Montserrat-SemiBold", size: 24)
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
    
    func setupCell(_ name: String) {
        titleLabel.text = name
    }
    
    private func updateAppearence() {
        titleLabel.textColor = Palette.Text.primary
    }
    
    private func configureSubviews() {
        addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
