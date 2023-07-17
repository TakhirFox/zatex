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
    
    let skipButton: BaseButton = {
        let view = BaseButton()
        view.set(style: .sedondary)
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
    
    func setupView(sendName: String, skipName: String) {
        sendButton.setTitle(sendName, for: .normal)
        skipButton.setTitle(skipName, for: .normal)
    }
    
    private func updateAppearence() {}
    
    private func configureSubviews() {
        addSubview(skipButton)
        addSubview(sendButton)
    }
    
    private func configureConstraints() {
        skipButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(skipButton.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(9)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
