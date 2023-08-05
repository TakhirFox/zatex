//
//  ProfileLoginView.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.08.2023.
//

import UIKit

class ProfileLoginView: UIView {
    
    var actionHandler: (() -> Void)?
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-Regular", size: 16)
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    private let loginButton: BaseButton = {
        let view = BaseButton()
        view.setTitle("Войти", for: .normal)
        view.addTarget(nil, action: #selector(showLoginView), for: .touchUpInside)
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
        imageView.image = UIImage(named: "logotype")
        titleLabel.text = "Чтобы продавать товары, писать продавцам и создавать свой магазин, нужно авторизоваться"
    }
    
    @objc func showLoginView() {
        actionHandler!()
    }
    
    private func updateAppearence() {
        loginButton.titleLabel?.textColor = Palette.Background.primary
        titleLabel.textColor = Palette.Text.tertiary
    }
    
    private func configureSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(loginButton)
    }
    
    private func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(150)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(36)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
