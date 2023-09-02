//
//  CheckboxEditCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 07.11.2022.
//

import UIKit

class CheckboxEditCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-SemiBold", size: 13)
        return view
    }()
    
    private let firstRatioButton: BaseRatioButton = {
        let view = BaseRatioButton()
        return view
    }()
    
    private let secondRatioButton: BaseRatioButton = {
        let view = BaseRatioButton()
        return view
    }()
    
    private let firstLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-Medium", size: 13)
        return view
    }()
    
    private let secondLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-Medium", size: 13)
        return view
    }()
    
    public var isFirstSelected = false
    public var updateView: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        contentView.isUserInteractionEnabled = false
        
        firstRatioButton.addTarget(self, action: #selector(tappedRatio), for: .touchUpInside)
        firstRatioButton.tag = 0
        secondRatioButton.addTarget(self, action: #selector(tappedRatio), for: .touchUpInside)
        secondRatioButton.tag = 1
        
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    @objc func tappedRatio(sender: UIButton) {
        firstRatioButton.isSelected = sender.tag == 0
        secondRatioButton.isSelected = sender.tag == 1
        isFirstSelected = sender.tag == 0 ? true : false
        self.updateView?()
    }
    
    func setupCell(name: String, firstName: String, secondName: String, isShop: Bool?) {
        titleLabel.text = name
        firstLabel.text = firstName
        secondLabel.text = secondName
        
        if isShop != nil {
            firstRatioButton.isSelected = isShop!
            secondRatioButton.isSelected = !isShop!
        }
    }
    
    private func updateAppearence() {
        titleLabel.textColor = Palette.Text.primary
        firstLabel.textColor = Palette.Text.primary
        secondLabel.textColor = Palette.Text.primary
    }
    
    private func configureSubviews() {
        addSubview(titleLabel)
        addSubview(firstRatioButton)
        addSubview(firstLabel)
        addSubview(secondRatioButton)
        addSubview(secondLabel)
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
        
        secondRatioButton.snp.makeConstraints { make in
            make.top.equalTo(firstRatioButton.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
            make.height.equalTo(22)
            make.width.equalTo(22)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.secondRatioButton.snp.centerY)
            make.leading.equalTo(self.secondRatioButton.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
