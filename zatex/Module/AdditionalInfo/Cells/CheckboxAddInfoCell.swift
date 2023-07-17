//
//  CheckboxAddInfoCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 17.07.2023.
//

import UIKit

class CheckboxAddInfoCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-SemiBold", size: 13)
        return view
    }()
    
    public let firstRatioButton: BaseRatioButton = {
        let view = BaseRatioButton()
        return view
    }()
    
    private let firstLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-Medium", size: 13)
        return view
    }()
    
    public var updateView: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        contentView.isUserInteractionEnabled = false
        
        firstRatioButton.addTarget(self, action: #selector(tappedRatio), for: .touchUpInside)
        firstRatioButton.tag = 0
        
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    @objc func tappedRatio(sender: UIButton) {
        firstRatioButton.isSelected = !firstRatioButton.isSelected
        self.updateView?()
    }
    
    func setupCell(name: String, firstName: String, isShop: Bool?) {
        titleLabel.text = name
        firstLabel.text = firstName
        
        if isShop != nil {
            firstRatioButton.isSelected = isShop!
        }
    }
    
    private func updateAppearence() {
        titleLabel.textColor = Palette.Text.primary
        firstLabel.textColor = Palette.Text.primary
    }
    
    private func configureSubviews() {
        addSubview(titleLabel)
        addSubview(firstRatioButton)
        addSubview(firstLabel)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(22)
        }
        
        firstRatioButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(22)
            make.width.equalTo(22)
        }
        
        firstLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.firstRatioButton.snp.centerY)
            make.leading.equalTo(self.firstRatioButton.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
