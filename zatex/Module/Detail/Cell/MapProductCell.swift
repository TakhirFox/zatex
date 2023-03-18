//
//  MapProductCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.11.2022.
//

import UIKit

class MapProductCell: UITableViewCell {
    
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont(name: "Montserrat-Medium", size: 15)
        return view
    }()
    
    private let mapView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        contentView.isUserInteractionEnabled = false
        
        mapView.backgroundColor = .red
        
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(map: ProductResult.Address?) {
        if let city = map?.city,
            let street = map?.street1 {
            titleLabel.text = "\(city), \(street)"
        }
    }
    
    private func updateAppearence() {
        titleLabel.textColor = Palette.AccentText.secondary
        backView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    private func configureSubviews() {
        addSubview(backView)
        backView.addSubview(titleLabel)
        backView.addSubview(mapView)
    }
    
    private func configureConstraints() {
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(6)
            make.height.equalTo(90)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(13)
            make.leading.equalToSuperview().inset(13)
            make.bottom.equalToSuperview().inset(13)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.leading.equalTo(self.titleLabel.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(6)
            make.bottom.equalToSuperview().inset(6)
            make.width.equalTo(100)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
