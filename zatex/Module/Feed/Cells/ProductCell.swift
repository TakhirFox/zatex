//
//  ProductCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 17.10.2022.
//

import UIKit
import Kingfisher

class ProductCell: UICollectionViewCell {
    
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
            make.bottom.equalToSuperview().inset(4)
            make.height.equalTo(14)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
    
}
