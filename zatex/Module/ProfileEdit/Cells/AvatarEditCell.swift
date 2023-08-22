//
//  AvatarEditCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 07.11.2022.
//

import UIKit

class AvatarEditCell: UITableViewCell {
    
    let avatarImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 75
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let darkView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.alpha = 0.5
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-Regular", size: 13)
        view.textAlignment = .center
        view.textColor = .white
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
    
    func setupCell(image: StoreInfoResult?, local: UIImage?) {
        titleLabel.text = "Изменить"
        
        if local != nil {
            avatarImage.image = local
            return
        }
        
        if image != nil {
            switch image?.gravatar {
            case .avatar(let avatar):
                let avatarUrl = URL(string: avatar)
                avatarImage.kf.setImage(with: avatarUrl)
                
            case .empty, nil:
                return
            }
        }
    }
    
    private func updateAppearence() {
        
    }
    
    private func configureSubviews() {
        addSubview(avatarImage)
        avatarImage.addSubview(darkView)
        darkView.addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        avatarImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.center.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
        
        darkView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
