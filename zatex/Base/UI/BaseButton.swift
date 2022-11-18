//
//  BaseButton.swift
//  zatex
//
//  Created by Zakirov Tahir on 26.10.2022.
//

import UIKit

class BaseButton: UIButton {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 50)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure() {
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func updateAppearence() {
        titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 15)
        backgroundColor = Palette.Button.primary
        tintColor = Palette.Background.secondary
        setTitleColor(Palette.Background.secondary, for: .normal)
        layer.cornerRadius = 8
    }
}
