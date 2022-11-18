//
//  BaseSwitch.swift
//  zatex
//
//  Created by Zakirov Tahir on 27.10.2022.
//

import UIKit

class BaseSwitch: UISwitch {
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
        onTintColor = Palette.Background.tertiary
        thumbTintColor = Palette.AccentText.primary
    }
}
