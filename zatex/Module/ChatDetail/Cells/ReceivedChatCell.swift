//
//  ReceivedChatCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.03.2023.
//

import UIKit
import SnapKit

class ReceivedChatCell: UITableViewCell {
    
    private let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private let messageLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.preferredMaxLayoutWidth = 300
        view.numberOfLines = 0
        return view
    }()
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.text = "12:75"
        view.font = .systemFont(ofSize: 12)
        view.textAlignment = .right
        view.numberOfLines = 1
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(_ data: ChatMessageResult?) {
        messageLabel.text = data?.content
        dateLabel.text = data?.sentAt // TODO: format
    }
    
    private func configureSubviews() {
        addSubview(bubbleView)
        bubbleView.addSubview(dateLabel)
        bubbleView.addSubview(messageLabel)
    }
    
    private func configureConstraints() {
        bubbleView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4)
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(4)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(bubbleView).inset(10)
            make.top.equalTo(bubbleView).inset(10)
            make.height.equalTo(16)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(bubbleView).inset(10)
            make.top.equalTo(dateLabel.snp.bottom).offset(2)
            make.bottom.equalTo(bubbleView).inset(10)
        }
    }
    
    private func updateAppearence() { // TODO: appearence
//        backgroundColor = Palette.Background.secondary
//        usernameLabel.textColor = Palette.Text.primary
//        productNameLabel.textColor = Palette.Text.primary
//        messageLabel.textColor = Palette.AccentText.secondary
//        dateLabel.textColor = Palette.AccentText.secondary
//        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
