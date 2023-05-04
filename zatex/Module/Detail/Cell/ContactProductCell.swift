//
//  ContactProductCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.11.2022.
//

import UIKit

class ContactProductCell: UICollectionViewCell {
    
    let callButton: BaseButton = {
        let view = BaseButton()
        view.set(style: .primary)
        return view
    }()
    
    let messageButton: BaseButton = {
        let view = BaseButton()
        view.set(style: .primary)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
                
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell() {
        callButton.setTitle("Позвонить", for: .normal)
        messageButton.setTitle("Написать", for: .normal)
    }
    
    private func updateAppearence() {}
    
    private func configureSubviews() {
        contentView.addSubview(callButton)
        contentView.addSubview(messageButton)
    }
    
    private func configureConstraints() {
        callButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.leading.equalToSuperview().inset(16)
            make.width.equalToSuperview().multipliedBy(1.0 / 2).offset(-16)
            make.bottom.equalToSuperview().offset(6)
        }
        
        messageButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.leading.equalTo(callButton.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(6)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
