//
//  SaveCityButtonView.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.12.2023.
//

import UIKit

class SaveCityButtonView: UIView {
    
    private let selectedView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-SemiBold", size: 13)
        return view
    }()
    
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
    
    func setupView(buttonName: String) {
        sendButton.setTitle(buttonName, for: .normal)
    }
    
    func setupTitle(title: String) {
        self.titleLabel.text = title
    }
    
    private func updateAppearence() {
        titleLabel.textColor = Palette.Text.primary
        selectedView.backgroundColor = Palette.Background.secondary
    }
    
    private func configureSubviews() {
        addSubview(selectedView)
        selectedView.addSubview(titleLabel)
        addSubview(sendButton)
    }
    
    private func configureConstraints() {
        selectedView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(selectedView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(9)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
