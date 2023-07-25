//
//  BaseToastView.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.07.2023.
//

import UIKit

class BaseToastView: UIView {
    
    var actionHandler: (() -> Void)?
    
    private var viewHeight = 60
    
    private let fullDescGesture = UITapGestureRecognizer()
    
    private let contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        return view
    }()
    
    private let wrongImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "wrongIcon")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-Regular", size: 11)
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    private let retryButton: UIButton = {
        let view = UIButton()
        view.setTitle("Повторить", for: .normal)
        view.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        view.addTarget(self, action: #selector(retryAction), for: .touchUpInside)
        return view
    }()
    
    private let fullDescriptionLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-Regular", size: 11)
        view.textAlignment = .left
        view.isHidden = true
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
        titleLabel.text = "Что-то произошло"
        descriptionLabel.text = "Не получилось связаться с сервером."
        fullDescriptionLabel.text = errorName
        
        wrongImageView.isUserInteractionEnabled = true
        wrongImageView.addGestureRecognizer(fullDescGesture)
        fullDescGesture.addTarget(self, action: #selector(fullDescriptionAction))
    }
    
    @objc private func retryAction() {
        actionHandler?()
    }
    
    @objc private func fullDescriptionAction() {
        viewHeight = viewHeight == 60 ? 200 : 60
        fullDescriptionLabel.isHidden = !fullDescriptionLabel.isHidden
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            self.contentView.snp.updateConstraints { make in
                make.height.equalTo(self.viewHeight)
            }
            
            self.layoutIfNeeded()
        }
    }
    
    private func updateAppearence() {
        contentView.backgroundColor = Palette.BorderField.primary
        titleLabel.textColor = Palette.Text.primary
        descriptionLabel.textColor = Palette.Text.secondary
        fullDescriptionLabel.textColor = Palette.Text.secondary
        retryButton.tintColor = Palette.Text.primary
        retryButton.setTitleColor(Palette.Text.primary, for: .normal)
    }
    
    private func configureSubviews() {
        addSubview(contentView)
        contentView.addSubview(wrongImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(retryButton)
        contentView.addSubview(fullDescriptionLabel)
    }
    
    private func configureConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(viewHeight)
        }
        
        wrongImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalTo(wrongImageView.snp.trailing).offset(8)
            make.bottom.equalTo(descriptionLabel.snp_top)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(wrongImageView.snp.trailing).offset(8)
        }
        
        retryButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalTo(descriptionLabel.snp.trailing).offset(8)
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(80)
        }
        
        fullDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(wrongImageView.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().offset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
