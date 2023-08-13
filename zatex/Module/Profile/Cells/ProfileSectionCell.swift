//
//  ProfileSectionCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 19.03.2023.
//

import UIKit

class ProfileSectionCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(name: String) {
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
            make.top.equalToSuperview().inset(4)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
