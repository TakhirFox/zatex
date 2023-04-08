//
//  BaseTextView.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.04.2023.
//

import UIKit

class BaseTextView: UITextView {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 150)
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        textContainerInset = UIEdgeInsets(top: 8, left: 11, bottom: 8, right: 11)
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
        font = UIFont(name: "Montserrat-SemiBold", size: 17)
        textColor = Palette.Text.secondary
        backgroundColor = Palette.Background.secondary
        layer.cornerRadius = 8
        layer.borderColor = Palette.BorderField.primary.cgColor
        layer.borderWidth = 2
    }
}
