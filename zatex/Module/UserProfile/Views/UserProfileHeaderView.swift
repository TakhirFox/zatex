//
//  UserProfileHeaderView.swift
//  zatex
//
//  Created by Zakirov Tahir on 14.08.2023.
//

import UIKit

class UserProfileHeaderView: UIView {
    
    private let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = false
        backgroundColor = .clear
        
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(store: StoreInfoResult?) {
        backgroundImageView.image = UIImage(named: "defaultBanner")
        
        if store?.banner != nil, !(store?.banner!.isEmpty)! {
            let banner = (store?.banner?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            let bannerUrl = URL(string: banner)
            
            backgroundImageView.kf.setImage(with: bannerUrl)
        }
    }
    
    private func updateAppearence() {}
    
    private func configureSubviews() {
        addSubview(backgroundImageView)
    }
    
    private func configureConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
