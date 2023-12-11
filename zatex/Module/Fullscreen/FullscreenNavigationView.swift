//
//  FullscreenNavigationView.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.05.2023.
//

import UIKit

class FullscreenNavigationView: UIView {
    
    private let topVerticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
    
    private let topHorizontalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .equalCentering
        return view
    }()
    
    let closeButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        view.tintColor = .white
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let countPhotoLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-SemiBold", size: 15)
        view.isUserInteractionEnabled = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        
        setupViews()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupViews() {
        topVerticalStackView.backgroundColor = .white.withAlphaComponent(0.1)
        countPhotoLabel.textColor = .white
    }
    
    func setCounter(selectedId: Int, countImages: Int) {
        countPhotoLabel.text = "\(selectedId + 1) из \(countImages)"
    }
    
    private func setupSubviews() {
        addSubview(topVerticalStackView)
        
        topVerticalStackView.addArrangedSubview(UIView())
        topVerticalStackView.addArrangedSubview(topHorizontalStackView)
        
        topHorizontalStackView.addArrangedSubview(UIView())
        topHorizontalStackView.addArrangedSubview(countPhotoLabel)
        topHorizontalStackView.addArrangedSubview(closeButton)
    }
    
    private func setupConstraints() {
        topVerticalStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        closeButton.snp.makeConstraints { make in
            make.width.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
