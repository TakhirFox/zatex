//
//  ChatListCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.03.2023.
//

import UIKit
import SnapKit

class ChatListCell: UITableViewCell {
    
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let avatarImageView: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let usernameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-SemiBold", size: 15)
        view.numberOfLines = 1
        return view
    }()
    
    private let productNameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-Regular", size: 15)
        view.numberOfLines = 1
        return view
    }()
    
    private let messageLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-Medium", size: 14)
        view.numberOfLines = 4
        return view
    }()
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-Regular", size: 12)
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
    
    func setupCell(_ data: ChatListResult?) {
//        avatarImageView.image = data. // TODO: Добавить реальный аватар
        
        usernameLabel.text = data?.displayName
        productNameLabel.text = data?.postTitle
        messageLabel.text = data?.content
        dateLabel.text = dateFormatter(data?.sentAt)
        
        let isRead = data?.isRead ?? false
        
        if isRead {
            backView.backgroundColor = Palette.ChatStyle.readChatCell
        } else {
            backView.backgroundColor = Palette.ChatStyle.unreadChatCell
        }
    }
    
    private func configureSubviews() {
        addSubview(backView)
        backView.addSubview(avatarImageView)
        backView.addSubview(usernameLabel)
        backView.addSubview(productNameLabel)
        backView.addSubview(messageLabel)
        backView.addSubview(dateLabel)
    }
    
    private func configureConstraints() {
        backView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.bottom.equalToSuperview().inset(2)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(8)
            make.height.width.equalTo(50)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(8)
            make.height.equalTo(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.trailing.trailing.equalToSuperview().inset(16)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(2)
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(8)
            make.height.equalTo(20)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).offset(4)
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(8)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    private func updateAppearence() {
        backgroundColor = .clear
        avatarImageView.backgroundColor = Palette.Background.tertiary
        usernameLabel.textColor = Palette.Text.primary
        productNameLabel.textColor = Palette.Text.primary
        messageLabel.textColor = Palette.AccentText.secondary
        dateLabel.textColor = Palette.AccentText.secondary
        selectionStyle = .none
    }
    
    private func dateFormatter(_ dateString: String?) -> String {
        let originalDate = DateFormatter()
        originalDate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let dateString = dateString,
                let date = originalDate.date(from: dateString) else { return "" }
        
        guard Date().timeIntervalSince(date) / 3600 >= 1 else {
            return "Только что"
        }
        
        let convertedDate = DateFormatter()
        convertedDate.locale = Locale(identifier: "ru_RU")
        
        if Calendar.current.isDateInToday(date) {
            convertedDate.dateFormat = "Сегодня в HH:mm"
        } else if Calendar.current.isDateInYesterday(date) {
            convertedDate.dateFormat = "Вчера в HH:mm"
        } else {
            convertedDate.dateFormat = "dd MMMM"
        }
        
        return convertedDate.string(from: date)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
