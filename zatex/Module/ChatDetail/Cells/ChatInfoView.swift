//
//  ChatInfoView.swift
//  zatex
//
//  Created by Zakirov Tahir on 13.03.2023.
//

import UIKit

class ChatInfoView: UIView {
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()
    
    private let verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    private let imageProductView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let authorNameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        return view
    }()
    
    private let productNameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-Medium", size: 10)
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
    
    func setupCell(author: String) { // TODO:
        imageProductView.image = UIImage(named: "asd")
        authorNameLabel.text = "NIKITARsT"
        productNameLabel.text = "iPHone 15 5tb 6g"
    }
    
    private func configureSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(imageProductView)
        stackView.addArrangedSubview(verticalStackView)
        verticalStackView.addArrangedSubview(authorNameLabel)
        verticalStackView.addArrangedSubview(productNameLabel)
    }
    
    private func configureConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview()
        }
        
        imageProductView.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
    }
    
    private func updateAppearence() {
        authorNameLabel.textColor = Palette.Text.primary
        productNameLabel.textColor = Palette.Text.primary
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
