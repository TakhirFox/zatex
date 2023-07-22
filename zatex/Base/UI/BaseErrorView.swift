//
//  BaseErrorView.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.07.2023.
//

import UIKit

class BaseErrorView: UIView {
    
    var actionHandler: (() -> Void)?
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-SemiBold", size: 20)
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-Medium", size: 14)
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    private let retryButton: BaseButton = {
        let view = BaseButton()
        view.set(style: .sedondary)
        view.setTitle("Повторить", for: .normal)
        view.addTarget(self, action: #selector(retryAction), for: .touchUpInside)
        return view
    }()
    
    private let fullDescriptionLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-Regular", size: 12)
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(errorName: String) {
        titleLabel.text = "Произошла ошибка"
        descriptionLabel.text = "Проверьте соединение с сетью и повторите загрузку. Если ошибка повторяется, обратитесь в тех. поддержку со скриншотом этого экрана"
        fullDescriptionLabel.text = errorName
    }
    
    @objc private func retryAction() {
        actionHandler?()
    }
    
    private func updateAppearence() {
        titleLabel.textColor = Palette.Text.primary
        descriptionLabel.textColor = Palette.Text.secondary
        fullDescriptionLabel.textColor = Palette.BorderField.primary
    }
    
    private func configureSubviews() {
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(retryButton)
        contentView.addSubview(fullDescriptionLabel)
    }
    
    private func configureConstraints() {
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.centerY.equalToSuperview()
            make.height.equalTo(300)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
        }
        
        retryButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
        }
        
        fullDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(retryButton.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
