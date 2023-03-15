//
//  BaseTabBar.swift
//  zatex
//
//  Created by Zakirov Tahir on 26.10.2022.
//

import UIKit

class BaseTabBar: UITabBar {
    let positionOnX: CGFloat = 10
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
        setUI()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setUI() {
        let width = bounds.width - positionOnX * 2
        let height = (bounds.height) + positionOnY * 2
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionOnX,
                                                          y: bounds.minY - positionOnY,
                                                          width: width,
                                                          height: height),
                                      cornerRadius: height / 2)
        
        roundLayer.path = bezierPath.cgPath
        
        layer.insertSublayer(roundLayer, at: 0)
        itemWidth = width / 6
        itemPositioning = .centered
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 10)!], for: .normal)
    }
    
    func updateAppearence() {
        roundLayer.fillColor = Palette.Background.tertiary.cgColor
        
        tintColor = Palette.AccentText.primary
        unselectedItemTintColor = Palette.AccentText.primary
    }

}
