//
//  ButtonStyle.swift
//  zatex
//
//  Created by Zakirov Tahir on 27.04.2023.
//

import UIKit

enum ButtonStyle {
    case primary
    case sedondary

    var backgroundColor: UIColor {
        switch self {
            case .primary:
                return Palette.Button.primary
            case .sedondary:
                return Palette.Button.secondary
        }
    }

    var tintColor: UIColor {
        switch self {
            case .primary:
                return Palette.Background.secondary
            case .sedondary:
                return Palette.Button.primary
        }
    }

    var cornerRadius: CGFloat {
        switch self {
            case .primary:
                return 8
            case .sedondary:
                return 8
        }
    }
}
