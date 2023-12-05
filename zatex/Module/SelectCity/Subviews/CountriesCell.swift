//
//  CountriesCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.12.2023.
//

import UIKit

class CountriesCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        contentView.isUserInteractionEnabled = false
        
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
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().offset(16)
            make.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
