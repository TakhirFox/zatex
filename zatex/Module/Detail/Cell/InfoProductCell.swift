//
//  InfoProductCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.11.2022.
//

import UIKit

class InfoProductCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        return view
    }()
    
    private let costLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-Medium", size: 20)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        contentView.isUserInteractionEnabled = false
        
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(name: String?, cost: String?) {
        titleLabel.text = name ?? ""
        
        if cost != nil {
            costLabel.text = "\(cost!) Р"
        }
    }
    
    private func updateAppearence() {
        titleLabel.textColor = Palette.Text.primary
        costLabel.textColor = Palette.Text.secondary
    }
    
    private func configureSubviews() {
        addSubview(titleLabel)
        addSubview(costLabel)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.trailing.equalToSuperview().offset(16)
        }
        
        costLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(6)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
