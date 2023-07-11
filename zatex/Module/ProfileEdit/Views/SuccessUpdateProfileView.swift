//
//  SuccessUpdateProfileView.swift
//  zatex
//
//  Created by Zakirov Tahir on 09.07.2023.
//

import UIKit

class SuccessUpdateProfileView: UIView {
    
    private let contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Сохранено!"
        view.textAlignment = .center
        view.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        view.numberOfLines = 1
        return view
    }()
    
    private let contentLabel: UILabel = {
        let view = UILabel()
        view.text = "Информация успешно сохранена"
        view.textAlignment = .center
        view.font = UIFont(name: "Montserrat-SemiBold", size: 13)
        view.numberOfLines = 0
        return view
    }()
    
    let okButton: BaseButton = {
        let view = BaseButton()
        view.set(style: .primary)
        view.setTitle("Хорошо", for: .normal)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black.withAlphaComponent(0.6)
        
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(store: String) {
        
    }
    
    private func updateAppearence() {
        titleLabel.textColor = Palette.Text.primary
        contentLabel.textColor = Palette.Text.primary
        contentView.backgroundColor = Palette.Background.primary
    }
    
    private func configureSubviews() {
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(okButton)
    }
    
    private func configureConstraints() {
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.centerY.equalToSuperview()
            make.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        okButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
