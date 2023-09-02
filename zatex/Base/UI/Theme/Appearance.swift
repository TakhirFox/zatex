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
            if UITraitCollection.current.userInterfaceStyle == .dark {
                Appearance.shared.theme.value = .dark
            } else {
                Appearance.shared.theme.value = .light
            }
        } else if selectedStyle == 1 {
            Appearance.shared.theme.value = .light
        } else {
            Appearance.shared.theme.value = .dark
        }
        
        configureSearchBar()
        configureComponents()
    }
}

fileprivate extension Appearance {
    static func configureComponents() { }
    static func configureSearchBar() { }
}
