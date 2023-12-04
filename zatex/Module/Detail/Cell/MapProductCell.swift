//
//  MapProductCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.11.2022.
//

import UIKit

class MapProductCell: UICollectionViewCell {
    
    private let backImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "map-preview")
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont(name: "Montserrat-Medium", size: 15)
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
    
    func setupCell(map: ProductResult.AddressUnion?) {
        switch map {
        case .address(let address):
            let street = address.street1 ?? ""
            let city = address.city ?? ""
            let country = address.country ?? ""
            
            titleLabel.text = "\(country), \(city), \(street)"
            
        case .empty,
                .none:
            titleLabel.text = "Адреса нет"
        }
    }
    
    private func updateAppearence() {
        titleLabel.textColor = Palette.Text.primary
    }
    
    private func configureSubviews() {
        addSubview(backImageView)
        backImageView.addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        backImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(6)
            make.height.equalTo(90)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
