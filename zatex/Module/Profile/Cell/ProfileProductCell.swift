//
//  ProfileProductCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 06.08.2023.
//

import UIKit
import Kingfisher

class ProfileProductCell: UICollectionViewCell {
    
    enum Signal {
        case toSales
        case toActive
    }
    
    var onSignal: (Signal) -> Void = { _ in }
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "title"
        view.font = UIFont(name: "Montserrat-SemiBold", size: 13)
        return view
    }()
    
    private let costLabel: UILabel = {
        let view = UILabel()
        view.text = "cost"
        view.font = UIFont(name: "Montserrat-Medium", size: 13)
        return view
    }()
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.text = "date"
        view.font = UIFont(name: "Montserrat-Regular", size: 11)
        return view
    }()
    
    private let productStateButton: BaseButton = {
        let view = BaseButton()
        view.set(style: .sedondary)
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(_ post: ProductResult?) {
        guard let post = post else { return }
        
        titleLabel.text = post.name
        imageView.image = UIImage(named: "no_image")
        dateLabel.text = dateFormatter(date: post.dateModified)
        
        if post.isSales ?? false {
            productStateButton.setTitle("Активировать", for: .normal)
            productStateButton.set(style: .primary)
            productStateButton.addTarget(self, action: #selector(setActiveState), for: .touchUpInside)
        } else {
            productStateButton.setTitle("Снять с продажи", for: .normal)
            productStateButton.set(style: .sedondary)
            productStateButton.addTarget(self, action: #selector(setSalesState), for: .touchUpInside)
        }
        
        if let cost = post.price {
            costLabel.text = "\(cost)"
        }
        
        if let imageUrl = post.images, let firstUrl = imageUrl.first, let src = firstUrl.src {
            let url = (src.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            let urlString = URL(string: url)
            imageView.kf.setImage(with: urlString)
        }
    }
    
    private func dateFormatter(date: String?) -> String {
        guard let date = date else { return ""}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let newDate = dateFormatter.date(from: date) ?? Date()
        let isCurrentDate = Calendar.current.isDateInToday(newDate)
        
        if isCurrentDate {
            dateFormatter.dateFormat = "HH:mm"
            let stringDate = dateFormatter.string(from: newDate)
            return "Сегодня, \(stringDate)"
        } else {
            dateFormatter.dateFormat = "dd MMMM, HH:mm"
            return dateFormatter.string(from: newDate)
        }
    }
    
    private func updateAppearence() {
        backgroundColor = Palette.Background.secondary
        titleLabel.textColor = Palette.Text.primary
        costLabel.textColor = Palette.Text.primary
        dateLabel.textColor = Palette.AccentText.secondary
    }
    
    private func configureSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(costLabel)
        addSubview(dateLabel)
        addSubview(productStateButton)
    }
    
    private func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4)
            make.leading.equalToSuperview().inset(4)
            make.trailing.equalToSuperview().inset(4)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(4)
            make.height.equalTo(14)
        }
        
        costLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(4)
            make.height.equalTo(14)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(costLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(4)
            make.height.equalTo(14)
        }
        
        productStateButton.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(4)
            make.height.equalTo(30)
            make.bottom.equalToSuperview().inset(4)
        }
    }
    
    @objc private func setSalesState() {
        onSignal(.toSales)
    }
    
    @objc private func setActiveState() {
        onSignal(.toActive)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
    
}
