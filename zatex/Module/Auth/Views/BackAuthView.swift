//
//  BackAuthView.swift
//  zatex
//
//  Created by Zakirov Tahir on 04.08.2023.
//

import UIKit

class BackAuthView: UIView {
    
    let logoImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "logotype")
        return view
    }()
    
    let foregroundImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "login-foreground")
        return view
    }()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private var numberOfItems:Int = 0
    private var previousLabel: UILabel? = nil
    private var yOffSet: Double = 0
    private var labelTexts: [String] = []
    public var width: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(patternImage: UIImage(named: "login-image") ?? UIImage())
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(text: [String], width: CGFloat) {
        labelTexts = text
        self.width = width
        setupText()
    }
    
    private func updateAppearence() {}
    
    private func configureSubviews() {
        addSubview(scrollView)
        addSubview(foregroundImage)
        addSubview(logoImage)
    }
    
    private func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(16)
        }
        
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(66)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        foregroundImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
    private func setupText() {
        for index in 0..<labelTexts.count {
            let textLabel: UILabel = {
                let view = UILabel()
                view.font = UIFont(name: "Montserrat-SemiBold", size: 38)
                view.numberOfLines = 0
                view.textColor = index % 2 == 0 ? Palette.Text.tertiary : Palette.Text.four
                view.text = labelTexts[index]
                return view
            }()
            
            scrollView.addSubview(textLabel)
            
            textLabel.snp.makeConstraints { make in
                if let previousLabel = previousLabel {
                    make.top.equalTo(previousLabel.snp.bottom).offset(6)
                } else {
                    make.top.equalToSuperview().offset(6)
                }
                make.width.equalTo(width - 16)
                make.leading.trailing.equalToSuperview()
            }
            
            previousLabel = textLabel
        }
    }
    
    @objc private func timerAction() {
        yOffSet -= 30;
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
                self.scrollView.contentOffset.y = self.yOffSet
            })
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
