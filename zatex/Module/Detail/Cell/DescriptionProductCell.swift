//
//  DescriptionProductCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.11.2022.
//

import UIKit

class DescriptionProductCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont(name: "Montserrat-Regular", size: 14)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
                
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(description: String) {
        titleLabel.text = description
    }
    
    private func updateAppearence() {
        titleLabel.textColor = Palette.Text.primary
    }
    
    private func configureSubviews() {
        addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(6)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
