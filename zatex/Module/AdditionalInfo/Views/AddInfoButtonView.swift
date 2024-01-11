//
//  AddInfoButtonView.swift
//  zatex
//
//  Created by Zakirov Tahir on 17.07.2023.
//

import UIKit

class AddInfoButtonView: UIView {
    
    let sendButton: BaseButton = {
        let view = BaseButton()
        view.set(style: .primary)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        isUserInteractionEnabled = true
        
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupView(sendName: String) {
        sendButton.setTitle(sendName, for: .normal)
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
