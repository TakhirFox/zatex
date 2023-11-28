//
//  BaseTabBar.swift
//  zatex
//
//  Created by Zakirov Tahir on 26.10.2022.
//

import UIKit

class BaseTabBar: UITabBar {
    let positionOnX: CGFloat = 16
    let positionOnY: CGFloat = 0
    
    let roundLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure() {
        setupUI()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupUI() {
        let width = bounds.width - positionOnX * 2
        let height = (bounds.height) + positionOnY * 2
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionOnX,
                y: bounds.minY - positionOnY - 5,
                width: width,
                height: height
            ),
            cornerRadius: height / 2
        )
        
        roundLayer.path = bezierPath.cgPath
        
        layer.insertSublayer(roundLayer, at: 0)
        itemWidth = width / 10
        itemPositioning = .centered
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 10)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .selected)
        
        isTranslucent = true
        backgroundImage = UIImage()
        shadowImage = UIImage()
    }
    
    func updateAppearence() {
        roundLayer.fillColor = Palette.Background.tertiary.cgColor
        
        tintColor = Palette.AccentText.primary
        unselectedItemTintColor = Palette.AccentText.primary
    }

}
