//
//  ButtonResetPasswordCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 30.05.2023.
//

import UIKit

class ButtonResetPasswordCell: UITableViewCell {
    
    let sendButton: BaseButton = {
        let view = BaseButton()
        view.set(style: .primary)
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
        sendButton.setTitle(name, for: .normal)
    }
    
    private func updateAppearence() {}
    
    private func configureSubviews() {
        addSubview(sendButton)
    }
    
    private func configureConstraints() {
        sendButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(9)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
