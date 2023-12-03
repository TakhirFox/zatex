//
//  ReviewDetailView.swift
//  zatex
//
//  Created by Zakirov Tahir on 28.04.2023.
//

import UIKit
import Lottie

class ReviewDetailView: UIView {
    
    private let contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Напишите отзыв!"
        view.textAlignment = .center
        view.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        view.numberOfLines = 1
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.spacing = 4
        return view
    }()
    
    private var ratingStarButtons: [UIButton] = []
    private var loaderView = LottieAnimationView(name: "loader")
    
    let textView: BaseTextView = {
        let view = BaseTextView()
        return view
    }()
    
    let sendReviewButton: BaseButton = {
        let view = BaseButton()
        view.set(style: .primary)
        view.setTitle("Отправить", for: .normal)
        return view
    }()
    
    var selectedRating = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black.withAlphaComponent(0.6)
        
        setupStars(0)
        configureSubviews()
        configureConstraints()
        updateAppearence()
        setLoader()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell() {}
    
    func setupStars(_ selectedIndex: Int) {
        ratingStarButtons.forEach { $0.removeFromSuperview() }
        ratingStarButtons.removeAll()
        
        for index in 1...5 {
            let starView = UIButton()
            starView.addTarget(self, action: #selector(tappedStar), for: .touchUpInside)
            starView.tag = index
            
            if selectedIndex + 1 <= starView.tag {
                starView.setImage(UIImage(named: "unstarIcon"), for: .normal)
            } else {
                starView.setImage(UIImage(named: "starIcon"), for: .normal)
            }
            
            ratingStarButtons.append(starView)
        }
        
        ratingStarButtons.forEach { stackView.addArrangedSubview($0) }
    }
    
    func startLoad(enable: Bool) {
        if enable {
            sendReviewButton.isUserInteractionEnabled = true
            loaderView.isHidden = false
            titleLabel.alpha = 0.5
            stackView.alpha = 0.5
            textView.alpha = 0.5
            sendReviewButton.alpha = 0.5
            loaderView.play()
            
        } else {
            sendReviewButton.isUserInteractionEnabled = false
            loaderView.isHidden = true
            titleLabel.alpha = 1
            stackView.alpha = 1
            textView.alpha = 1
            sendReviewButton.alpha = 1
            loaderView.stop()
        }
    }
        
    @objc func tappedStar(_ sender: UIButton) {
        setupStars(sender.tag)
        selectedRating = sender.tag
    }
    
    private func updateAppearence() {
        titleLabel.textColor = Palette.Text.primary
        contentView.backgroundColor = Palette.Background.primary
    }
    
    private func configureSubviews() {
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(stackView)
        contentView.addSubview(textView)
        contentView.addSubview(sendReviewButton)
        contentView.addSubview(loaderView)
    }
    
    private func configureConstraints() {
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.centerY.equalToSuperview()
            make.height.equalTo(300)
        }
        
        loaderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(40)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        sendReviewButton.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func setLoader() {
        loaderView.contentMode = .scaleAspectFill
        loaderView.loopMode = .loop
        loaderView.animationSpeed = 2
        loaderView.isHidden = true
        loaderView.stop()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
