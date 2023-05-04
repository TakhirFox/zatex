//
//  BaseButton.swift
//  zatex
//
//  Created by Zakirov Tahir on 26.10.2022.
//

import UIKit

class BaseButton: UIButton {
    
    private var style: ButtonStyle?
    
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
    
    open func set(style: ButtonStyle) {
        self.style = style
        updateAppearence()
    }
    
    private func configure() {
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    private func updateAppearence() {
        guard let style = style else { return }
        
        titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 15)
        backgroundColor = style.backgroundColor
        tintColor = style.tintColor
        setTitleColor(style.tintColor, for: .normal)
        layer.cornerRadius = style.cornerRadius
    }
}
