//
//  ChatListCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.03.2023.
//

import UIKit
import SnapKit

class ChatListCell: UITableViewCell {
    
    private let avatarImageView: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.image = UIImage(named: "asd")
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let usernameLabel: UILabel = {
        let view = UILabel()
        view.text = "Петр Петушкевич"
        view.font = .boldSystemFont(ofSize: 16)
        view.numberOfLines = 1
        return view
    }()
    
    private let productNameLabel: UILabel = {
        let view = UILabel()
        view.text = "Игровая приставка ПениСтейшн 6"
        view.font = .systemFont(ofSize: 16)
        view.numberOfLines = 1
        return view
    }()
    
    private let messageLabel: UILabel = {
        let view = UILabel()
        view.text = "Добрый день. Если вы продаете товар за эту цену, тогда не интересно вовсе!!! Ищите лоха где нибудь в другом месте! Меня вы не одурачите. Всего доброго. А хотя знаете что? А нет, ничего"
        view.font = .systemFont(ofSize: 15)
        view.numberOfLines = 4
        return view
    }()
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.text = "12:75"
        view.font = .systemFont(ofSize: 14)
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
        usernameLabel.text = data?.displayName
        productNameLabel.text = data?.postTitle
        messageLabel.text = data?.content
        dateLabel.text = data?.sentAt //TODO: Тут отформативанная дата
    }
    
    private func configureSubviews() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        addSubview(productNameLabel)
        addSubview(messageLabel)
    }
    
    private func configureConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(16)
            make.height.width.equalTo(50)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.trailing.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(8)
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
        backgroundColor = Palette.Background.secondary
        usernameLabel.textColor = Palette.Text.primary
        productNameLabel.textColor = Palette.Text.primary
        messageLabel.textColor = Palette.AccentText.secondary
        dateLabel.textColor = Palette.AccentText.secondary
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
