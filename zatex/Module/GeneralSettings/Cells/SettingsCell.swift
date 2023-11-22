//
//  SettingsCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.11.2022.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    private let backView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let iconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-SemiBold", size: 13)
        return view
    }()
    
    private let subTitleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-Medium", size: 11)
        return view
    }()
    
    private let rightIconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private var isDestructive = false
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        backView.layer.cornerRadius = 8
        
        configureSubviews()
        configureConstraints()
        
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(_ settings: SettingsModel) {
        iconView.image = UIImage(named: settings.icon)?
            .withTintColor(
                settings.isDestructive ? Palette.BorderField.wrong : Palette.AccentText.secondary,
                renderingMode: .alwaysOriginal
            )
        
        titleLabel.text = settings.title
        subTitleLabel.text = settings.subTitle
        rightIconView.image = UIImage(named: settings.rightIcon ?? "")
        
        isDestructive = settings.isDestructive
        
        updateAppearence()
    }
    
    private func updateAppearence() {
        backView.backgroundColor = Palette.Background.secondary
        titleLabel.textColor = isDestructive ? Palette.BorderField.wrong : Palette.Text.primary
        subTitleLabel.textColor = isDestructive ? Palette.BorderField.wrong : Palette.AccentText.secondary
    }
    
    private func configureSubviews() {
        addSubview(backView)
        backView.addSubview(iconView)
        backView.addSubview(titleLabel)
        backView.addSubview(subTitleLabel)
        backView.addSubview(rightIconView)
        
    }
    
    private func configureConstraints() {
        backView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(10)
            make.height.equalTo(60)
        }
        
        iconView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalTo(iconView.snp.trailing).offset(8)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(iconView.snp.trailing).offset(8)
            make.bottom.equalToSuperview().inset(12)
        }
        
        rightIconView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
            make.width.equalTo(13)
            make.height.equalTo(22)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
