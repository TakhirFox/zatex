//
//  ReviewsCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 20.03.2023.
//

import UIKit
import SnapKit

class ReviewsCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let bottomContainerView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        return view
    }()
    
    private let reviewTextLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-Regular", size: 12)
        view.numberOfLines = 0
        return view
    }()
    
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        view.numberOfLines = 1
        return view
    }()
    
    private let productNameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-Medium", size: 12)
        view.numberOfLines = 1
        return view
    }()
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-Regular", size: 12)
        view.numberOfLines = 1
        view.textAlignment = .right
        return view
    }()
    
    private let avatarImageView: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let ratingStarView: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
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
    
    func setupCell(reviews: ReviewsListResult?) {
        backgroundColor = .clear
        selectionStyle = .none
        
        reviewTextLabel.text = reviews?.content
        nameLabel.text = reviews?.author?.name
        productNameLabel.text = "На товар: \(reviews?.title ?? "")"
        dateLabel.text = dateFormatter(reviews?.date)
        ratingStarView.image = UIImage(named: "rat0")
        
        if reviews?.author?.avatar != nil {
            let avatar = (reviews?.author?.avatar?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            let avatarUrl = URL(string: avatar)
            
            avatarImageView.kf.setImage(with: avatarUrl)
        }
        
        if let rating = reviews?.rating {
            let intValue = Double(rating)
            let roundRating = round(intValue)
            let ratingStar = "rat\(roundRating)"
            ratingStarView.image = UIImage(named: ratingStar)
        }
    }
    
    private func configureSubviews() {
        addSubview(containerView)
        containerView.addSubview(reviewTextLabel)
        containerView.addSubview(bottomContainerView)
        bottomContainerView.addSubview(nameLabel)
        bottomContainerView.addSubview(productNameLabel)
        bottomContainerView.addSubview(dateLabel)
        bottomContainerView.addSubview(avatarImageView)
        bottomContainerView.addSubview(ratingStarView)
    }
    
    private func configureConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(9)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        reviewTextLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        bottomContainerView.snp.makeConstraints { make in
            make.top.equalTo(reviewTextLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(12)
            make.trailing.equalTo(dateLabel.snp.leading).offset(8)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(12)
        }
        
        ratingStarView.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).offset(2)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(12)
            make.bottom.equalToSuperview().inset(4)
            make.height.equalTo(15)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().inset(12)
            make.width.equalTo(100)
        }
    }
    
    private func updateAppearence() {
        containerView.backgroundColor = Palette.Background.secondary
        bottomContainerView.backgroundColor = Palette.BorderField.primary
        reviewTextLabel.textColor = Palette.Text.primary
        nameLabel.textColor = Palette.Text.primary
        productNameLabel.textColor = Palette.Text.primary
        dateLabel.textColor = Palette.AccentText.secondary
    }
    
    private func dateFormatter(_ dateString: String?) -> String {
        let originalDate = DateFormatter()
        originalDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        guard let dateString = dateString,
                let date = originalDate.date(from: dateString) else { return "" }
        
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
