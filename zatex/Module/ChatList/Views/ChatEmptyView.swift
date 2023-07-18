//
//  ChatEmptyView.swift
//  zatex
//
//  Created by Zakirov Tahir on 18.07.2023.
//

import UIKit

class ChatEmptyView: UIView {
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.textAlignment = .center
        view.font = UIFont(name: "Montserrat-SemiBold", size: 18)
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
    
    func setupCell(text: String) {
        titleLabel.text = text
    }
    
    private func updateAppearence() {
        titleLabel.textColor = Palette.Text.primary
    }
    
    private func configureSubviews() {
        addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
