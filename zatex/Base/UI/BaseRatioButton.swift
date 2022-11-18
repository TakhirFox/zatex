//
//  BaseRatioButton.swift
//  zatex
//
//  Created by Zakirov Tahir on 07.11.2022.
//

import UIKit

class BaseRatioButton: UIButton {
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
        self.backgroundColor = .clear
        self.tintColor = .clear
        self.setTitle("", for: .normal)
        self.setImage(UIImage(named: "UnselectedIcon")?.withTintColor(Palette.Background.tertiary, renderingMode: .alwaysOriginal), for: .normal)
        self.setImage(UIImage(named: "SelectedIcon")?.withTintColor(Palette.AccentText.secondary, renderingMode: .alwaysOriginal), for: .highlighted)
        self.setImage(UIImage(named: "SelectedIcon")?.withTintColor(Palette.AccentText.secondary, renderingMode: .alwaysOriginal), for: .selected)
    }
    
    
}
