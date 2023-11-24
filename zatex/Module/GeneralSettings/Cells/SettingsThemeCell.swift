//
//  SettingsThemeCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 03.09.2023.
//

import UIKit

class SettingsThemeCell: UITableViewCell {
    
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
    
    private let systemThemeRatioButton: BaseRatioButton = {
        let view = BaseRatioButton()
        return view
    }()
    
    private let lightThemeRatioButton: BaseRatioButton = {
        let view = BaseRatioButton()
        return view
    }()
    
    private let darkThemeRatioButton: BaseRatioButton = {
        let view = BaseRatioButton()
        return view
    }()
    
    private let systemThemeLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-Medium", size: 13)
        return view
    }()
    
    private let lightThemeLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-Medium", size: 13)
        return view
    }()
    
    private let darkThemeLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-Medium", size: 13)
        return view
    }()
    
    public var setThemeAction: ((Int) -> Void)?
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        contentView.isUserInteractionEnabled = false
        backView.layer.cornerRadius = 8
        
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(_ settings: SettingsModel, currentTheme: Int) {
        iconView.image = UIImage(named: settings.icon)?.withTintColor(Palette.AccentText.secondary, renderingMode: .alwaysOriginal)
        titleLabel.text = settings.title
        subTitleLabel.text = settings.subTitle
        
        systemThemeLabel.text = "Как в системе"
        lightThemeLabel.text = "Светлая тема"
        darkThemeLabel.text = "Темная тема"
        
        switch currentTheme {
        case 0:
            systemThemeRatioButton.isSelected = true
            
        case 1:
            lightThemeRatioButton.isSelected = true
            
        case 2:
            darkThemeRatioButton.isSelected = true
            
        default:
            break
        }
        
        systemThemeRatioButton.addTarget(self, action: #selector(tappedRatio), for: .touchUpInside)
        systemThemeRatioButton.tag = 0
        lightThemeRatioButton.addTarget(self, action: #selector(tappedRatio), for: .touchUpInside)
        lightThemeRatioButton.tag = 1
        darkThemeRatioButton.addTarget(self, action: #selector(tappedRatio), for: .touchUpInside)
        darkThemeRatioButton.tag = 2
    }
    
    
    @objc func tappedRatio(sender: UIButton) {
        systemThemeRatioButton.isSelected = false
        lightThemeRatioButton.isSelected = false
        darkThemeRatioButton.isSelected = false
        
        switch sender.tag {
        case 0:
            systemThemeRatioButton.isSelected = true
            setThemeAction!(0)
        case 1:
            lightThemeRatioButton.isSelected = true
            setThemeAction!(1)
        case 2:
            darkThemeRatioButton.isSelected = true
            setThemeAction!(2)
        default:
            break
        }
    }
    
    private func updateAppearence() {
        backView.backgroundColor = Palette.Background.secondary
        titleLabel.textColor = Palette.Text.primary
        subTitleLabel.textColor = Palette.AccentText.secondary
        
        systemThemeLabel.textColor = Palette.Text.primary
        lightThemeLabel.textColor = Palette.Text.primary
        darkThemeLabel.textColor = Palette.Text.primary
    }
    
    private func configureSubviews() {
        addSubview(backView)
        backView.addSubview(iconView)
        backView.addSubview(titleLabel)
        backView.addSubview(subTitleLabel)
        backView.addSubview(systemThemeRatioButton)
        backView.addSubview(lightThemeRatioButton)
        backView.addSubview(darkThemeRatioButton)
        backView.addSubview(systemThemeLabel)
        backView.addSubview(lightThemeLabel)
        backView.addSubview(darkThemeLabel)
    }
    
    private func configureConstraints() {
        backView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(10)
            make.height.equalTo(140)
        }
        
        iconView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(8)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.height.equalTo(22)
            make.leading.equalTo(iconView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(iconView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        
        systemThemeRatioButton.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(8)
            make.leading.equalTo(iconView.snp.trailing).offset(8)
            make.height.equalTo(22)
            make.width.equalTo(22)
        }
        
        systemThemeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.systemThemeRatioButton.snp.centerY)
            make.leading.equalTo(self.systemThemeRatioButton.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
        }
        
        lightThemeRatioButton.snp.makeConstraints { make in
            make.top.equalTo(systemThemeRatioButton.snp.bottom).offset(4)
            make.leading.equalTo(iconView.snp.trailing).offset(8)
            make.height.equalTo(22)
            make.width.equalTo(22)
        }
        
        lightThemeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.lightThemeRatioButton.snp.centerY)
            make.leading.equalTo(self.lightThemeRatioButton.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
        }
        
        darkThemeRatioButton.snp.makeConstraints { make in
            make.top.equalTo(lightThemeRatioButton.snp.bottom).offset(4)
            make.leading.equalTo(iconView.snp.trailing).offset(8)
            make.height.equalTo(22)
            make.width.equalTo(22)
            make.bottom.equalToSuperview().inset(12)
        }
        
        darkThemeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.darkThemeRatioButton.snp.centerY)
            make.leading.equalTo(self.darkThemeRatioButton.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
