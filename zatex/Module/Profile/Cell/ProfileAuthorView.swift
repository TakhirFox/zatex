//
//  ProfileAuthorView.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.11.2022.
//

import UIKit

class ProfileAuthorView: UIView {
    
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let avatarView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 40
        view.layer.masksToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        return view
    }()
    
    private let ratingView: UIImageView = {
        let view = UIImageView()
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
    
    func setupCell(name: String) { // TODO: Изменить
        avatarView.image = UIImage(named: "avatar")
        titleLabel.text = "NikitaRSTBest"
        ratingView.image = UIImage(named: "rat4")
    }
    
    func updateView(scrollView: UIScrollView) {
        let zeroPoint = -scrollView.contentOffset.y - scrollView.contentInset.top
        let pointInfo = ((-scrollView.contentOffset.y - scrollView.contentInset.top) / 10) + 16
        let fromLeadingToCenterInfo = max(0, min(pointInfo, 16))
        
        backView.layer.cornerRadius = max(min(pointInfo, 8), 0)
        
        backView.snp.updateConstraints { make in
            make.leading.trailing.equalToSuperview().inset(fromLeadingToCenterInfo)
        }
        
        
        let sizeForAvatar = -scrollView.contentOffset.y / 2
        let avatarSize = max(40, min(sizeForAvatar, 80))
        let halfScreen = frame.width / 2
        let halfTitleView = titleLabel.frame.width / 2
        let halfAvatarView = avatarView.frame.width / 2
        let paddingBetweenAvatarAndTitle = 8.0
        let leadingAvatar = max(8, min(-zeroPoint, halfScreen - halfTitleView - halfAvatarView - paddingBetweenAvatarAndTitle))
        let bottomAvatar = max(8, min(-zeroPoint / 10, 10))
        
        avatarView.layer.cornerRadius = max(20, min(sizeForAvatar / 2, 40))
        
        avatarView.snp.updateConstraints { make in
            make.leading.equalToSuperview().offset(leadingAvatar)
            make.height.equalTo(avatarSize)
            make.width.equalTo(avatarSize)
            make.bottom.equalToSuperview().inset(bottomAvatar)
        }
        
        
        let titleSize = max(26, min(-zeroPoint / 5, 54))
        
        titleLabel.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(titleSize)
        }
        
        
        let ratingOpacity = max(0.0, min(zeroPoint * 0.01 + 1, 1.0))
        
        ratingView.alpha = ratingOpacity
    }
    
    private func updateAppearence() {
        backView.backgroundColor = Palette.Background.secondary
        titleLabel.textColor = Palette.Text.primary
    }
    
    private func configureSubviews() {
        addSubview(backView)
        backView.addSubview(avatarView)
        backView.addSubview(titleLabel)
        backView.addSubview(ratingView)
    }
    
    private func configureConstraints() {
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
        avatarView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().inset(8)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(26)
            make.leading.equalTo(self.avatarView.snp.trailing).offset(10)
        }
        
        ratingView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(26)
            make.leading.equalTo(self.avatarView.snp.trailing).offset(10)
        }
                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
