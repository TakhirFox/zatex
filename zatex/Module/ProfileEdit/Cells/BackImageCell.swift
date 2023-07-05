//
//  BackImageCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 07.11.2022.
//

import UIKit

class BackImageCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-SemiBold", size: 13)
        return view
    }()
    
    private let avatarImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
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
    
    func setupCell(name: String, image: String?) {
        titleLabel.text = name
        
        if image != nil {
            let bannerUrl = URL(string: image!)
            
            avatarImage.kf.setImage(with: bannerUrl)
        }
    }
    
    private func updateAppearence() {
        titleLabel.textColor = Palette.Text.primary
    }
    
    private func configureSubviews() {
        addSubview(titleLabel)
        addSubview(avatarImage)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        avatarImage.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            make.height.equalTo(120)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
