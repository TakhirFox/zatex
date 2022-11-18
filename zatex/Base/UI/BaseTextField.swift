//
//  BaseTextField.swift
//  zatex
//
//  Created by Zakirov Tahir on 27.10.2022.
//

import UIKit

class BaseTextField: UITextField {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 50)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
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
        font = UIFont(name: "Montserrat-SemiBold", size: 17)
        textColor = Palette.Text.secondary
        backgroundColor = Palette.Background.secondary
        layer.cornerRadius = 8
        layer.borderColor = Palette.BorderField.primary.cgColor
        layer.borderWidth = 2
    }
}
