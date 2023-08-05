//
//  ThemeManager.swift
//  zatex
//
//  Created by Zakirov Tahir on 17.10.2022.
//

import UIKit

public enum Color {
    static public let primaryBackgroundLight = UIColor(hex: 0xF4F8FF)
    static public let secondaryBackgroundLight = UIColor(hex: 0xFFFFFF)
    static public let tertiaryBackgroundLight = UIColor(hex: 0xCEF1FF)
    
    static public let primaryTextLight = UIColor(hex: 0x363636)
    static public let secondaryTextLight = UIColor(hex: 0x98A8C2)
    static public let tertiaryTextLight = UIColor(hex: 0xB9B2FF)
    static public let fourTextLight = UIColor(hex: 0x7670B0)
    
    static public let primaryTextAccentLight = UIColor(hex: 0x38B3F7)
    static public let secondaryTextAccentLight = UIColor(hex: 0x4EB2E3)
    
    static public let filedStrokeLight = UIColor(hex: 0xEDF3FD)
    static public let wrongFiledStrokeLight = UIColor(hex: 0xFF7373)
    static public let primaryButtonLight = UIColor(hex: 0xF78628)
    static public let secondaryButtonLight = UIColor(hex: 0xFFD2AD)
    
    static public let backgroundMyBubbleLight = UIColor(hex: 0x83C0DB)
    static public let backgroundYourBubbleLight = UIColor(hex: 0xB6CEF4)
    static public let textMessageLight = UIColor(hex: 0x363636)
    static public let timeMessageLight = UIColor(hex: 0xEDF3FD)
    static public let backChatUnreadLight = UIColor(hex: 0x000000).withAlphaComponent(0.1)
    static public let backChatReadLight = UIColor.clear
    
    // Dark
    static public let primaryBackgroundDark = UIColor(hex: 0x202020)
    static public let secondaryBackgroundDark = UIColor(hex: 0x292929)
    static public let tertiarybackgroundDark = UIColor(hex: 0x4E656F)
    
    static public let primaryTextDark = UIColor(hex: 0xE1E1E1)
    static public let secondaryTextDark = UIColor(hex: 0x98A8C2)
    static public let tertiaryTextDark = UIColor(hex: 0xB9B2FF)
    static public let fourTextDark = UIColor(hex: 0x7670B0)
    
    static public let primaryTextAccentDark = UIColor(hex: 0xCEF1FF)
    static public let secondaryTextAccentDark = UIColor(hex: 0xA0E0FF)
    
    static public let filedStrokeDark = UIColor(hex: 0x454545)
    static public let wrongFiledStrokeDark = UIColor(hex: 0xFF7373)
    static public let primaryButtonDark = UIColor(hex: 0xED9349)
    static public let secondaryButtonDark = UIColor(hex: 0x654021)
    
    static public let backgroundMyBubbleDark = UIColor(hex: 0x4E656F)
    static public let backgroundYourBubbleDark = UIColor(hex: 0x68707C)
    static public let textMessageDark = UIColor(hex: 0xE1E1E1)
    static public let timeMessageDark = UIColor(hex: 0x98A8C2)
    static public let backChatUnreadDark = UIColor(hex: 0xFFFFFF).withAlphaComponent(0.1)
    static public let backChatReadDark = UIColor(hex: 0x000000).withAlphaComponent(0.1)
}

var currentTheme: AppTheme { Appearance.shared.theme.value }

public enum Palette {
    
    // MARK: Backgrounc Style
    public enum Background {
        public static var primary: UIColor {
            switch currentTheme {
            case .light:
                return Color.primaryBackgroundLight
            case .dark:
                return Color.primaryBackgroundDark
            }
        }
        
        public static var secondary: UIColor {
            switch currentTheme {
            case .light:
                return Color.secondaryBackgroundLight
            case .dark:
                return Color.secondaryBackgroundDark
            }
        }
        
        public static var tertiary: UIColor {
            switch currentTheme {
            case .light:
                return Color.tertiaryBackgroundLight
            case .dark:
                return Color.tertiarybackgroundDark
            }
        }
    }
    
    // MARK: Backgrounc Style
    public enum Button {
        public static var primary: UIColor {
            switch currentTheme {
            case .light:
                return Color.primaryButtonLight
            case .dark:
                return Color.primaryButtonDark
            }
        }
        
        public static var secondary: UIColor {
            switch currentTheme {
            case .light:
                return Color.secondaryButtonLight
            case .dark:
                return Color.secondaryButtonDark
            }
        }
    }
    
    // MARK: - Text Styles
    public enum Text {
        public static var primary: UIColor {
            switch currentTheme {
            case .light:
                return Color.primaryTextLight
            case .dark:
                return Color.primaryTextDark
            }
        }
        
        public static var secondary: UIColor {
            switch currentTheme {
            case .light:
                return Color.secondaryTextLight
            case .dark:
                return Color.secondaryTextDark
            }
        }
        
        public static var tertiary: UIColor {
            switch currentTheme {
            case .light:
                return Color.tertiaryTextLight
            case .dark:
                return Color.tertiaryTextDark
            }
        }
        
        public static var four: UIColor {
            switch currentTheme {
            case .light:
                return Color.fourTextLight
            case .dark:
                return Color.fourTextDark
            }
        }
    }
    
    // MARK: - Accent Text Styles
    public enum AccentText {
        public static var primary: UIColor {
            switch currentTheme {
            case .light:
                return Color.primaryTextAccentLight
            case .dark:
                return Color.primaryTextAccentDark
            }
        }
        
        public static var secondary: UIColor {
            switch currentTheme {
            case .light:
                return Color.secondaryTextAccentLight
            case .dark:
                return Color.secondaryTextAccentDark
            }
        }
    }
    
    // MARK: - Border Field Styles
    public enum BorderField {
        public static var primary: UIColor {
            switch currentTheme {
            case .light:
                return Color.filedStrokeLight
            case .dark:
                return Color.filedStrokeDark
            }
        }
        
        public static var wrong: UIColor {
            switch currentTheme {
            case .light:
                return Color.wrongFiledStrokeLight
            case .dark:
                return Color.wrongFiledStrokeDark
            }
        }
    }
    
    // MARK: - Chat style
    public enum ChatStyle {
        public static var myBubble: UIColor {
            switch currentTheme {
            case .light:
                return Color.backgroundMyBubbleLight
            case .dark:
                return Color.backgroundMyBubbleDark
            }
        }
        
        public static var yourBubble: UIColor {
            switch currentTheme {
            case .light:
                return Color.backgroundYourBubbleLight
            case .dark:
                return Color.backgroundYourBubbleDark
            }
        }
        
        public static var text: UIColor {
            switch currentTheme {
            case .light:
                return Color.textMessageLight
            case .dark:
                return Color.textMessageDark
            }
        }
        
        public static var time: UIColor {
            switch currentTheme {
            case .light:
                return Color.timeMessageLight
            case .dark:
                return Color.timeMessageDark
            }
        }
        
        public static var unreadChatCell: UIColor {
            switch currentTheme {
            case .light:
                return Color.backChatUnreadLight
            case .dark:
                return Color.backChatUnreadDark
            }
        }
        
        public static var readChatCell: UIColor {
            switch currentTheme {
            case .light:
                return Color.backChatReadLight
            case .dark:
                return Color.backChatReadDark
            }
        }
    }
}
