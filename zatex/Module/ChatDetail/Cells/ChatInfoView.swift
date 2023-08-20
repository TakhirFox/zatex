//
//  ChatInfoView.swift
//  zatex
//
//  Created by Zakirov Tahir on 13.03.2023.
//

import UIKit

class ChatInfoView: UIView {
    
    enum Signal {
        case onOpenAuthor(id: String)
        case onOpenProduct(id: String)
    }
    
    var onSignal: (Signal) -> Void = { _ in }
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()
    
    private let verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    private let imageProductView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .gray
        return view
    }()
    
    private let authorNameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        return view
    }()
    
    private let productNameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-Medium", size: 10)
        return view
    }()
    
    private var author: ChatInfoResult?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(author: ChatInfoResult?) {
        self.author = author
        
        if author?.imageURL != nil {
            let image = (author!.imageURL?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            let imageUrl = URL(string: image)
            
            imageProductView.kf.setImage(with: imageUrl)
        }
        
        authorNameLabel.text = author?.authorUsername ?? ""
        productNameLabel.text = author?.authorProduct ?? ""
        
        authorNameLabel.isUserInteractionEnabled = true
        productNameLabel.isUserInteractionEnabled = true
        imageProductView.isUserInteractionEnabled = true
        
        authorNameLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openAccountAction)))
        productNameLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openAccountAction)))
        imageProductView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openProductAction)))
    }
    
    private func configureSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(imageProductView)
        stackView.addArrangedSubview(verticalStackView)
        verticalStackView.addArrangedSubview(authorNameLabel)
        verticalStackView.addArrangedSubview(productNameLabel)
    }
    
    private func configureConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview()
        }
        
        imageProductView.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
    }
    
    private func updateAppearence() {
        authorNameLabel.textColor = Palette.Text.primary
        productNameLabel.textColor = Palette.Text.primary
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatInfoView {
    
    @objc private func openAccountAction() {
        if let authorID = author?.authorID {
            onSignal(.onOpenAuthor(id: authorID))
        }
    }
    
    @objc private func openProductAction() {
        if let productID = author?.productID {
            onSignal(.onOpenProduct(id: productID))
        }
    }
}
