//
//  Appearance.swift
//  zatex
//
//  Created by Zakirov Tahir on 17.10.2022.
//

import UIKit

enum AppTheme {
    case light
    case dark
}

final class Appearance {
    public static let shared = Appearance()
    
    var theme: Dynamic<AppTheme> = Dynamic(AppTheme.light)
    
    static func apply() {
        let selectedStyle = UserDefaults.standard.integer(forKey: "selectedStyle")

        if selectedStyle == 0 {
            Appearance.shared.theme.value = .light
        } else {
            Appearance.shared.theme.value = .dark
        }
        
        configureSearchBar()
        configureComponents()
        configureNavigationBar()
    }
}

fileprivate extension Appearance {
    static func configureComponents() { }

    static func configureNavigationBar() {
        UINavigationBar.appearance().backgroundColor = .brown
    
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundEffect = .none
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
        UITabBar.appearance().tintColor = Palette.Text.secondary
        UITabBar.appearance().unselectedItemTintColor = Palette.Text.primary
    }
    
    static func configureSearchBar() { }
}
