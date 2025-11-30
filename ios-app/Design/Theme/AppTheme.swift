//
//  AppTheme.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import UIKit

/// Comprehensive design system and theme management
struct AppTheme {
    
    // MARK: - Colors
    struct Colors {
        // Primary Colors
        static let primary = UIColor.systemBlue
        static let primaryDark = UIColor.systemBlue.withAlphaComponent(0.8)
        static let primaryLight = UIColor.systemBlue.withAlphaComponent(0.6)
        
        // Secondary Colors
        static let secondary = UIColor.systemIndigo
        static let secondaryDark = UIColor.systemIndigo.withAlphaComponent(0.8)
        static let secondaryLight = UIColor.systemIndigo.withAlphaComponent(0.6)
        
        // Background Colors
        static let background = UIColor.systemBackground
        static let backgroundSecondary = UIColor.secondarySystemBackground
        static let backgroundTertiary = UIColor.tertiarySystemBackground
        static let surface = UIColor.systemBackground
        
        // Text Colors
        static let textPrimary = UIColor.label
        static let textSecondary = UIColor.secondaryLabel
        static let textTertiary = UIColor.tertiaryLabel
        
        // Status Colors
        static let success = UIColor.systemGreen
        static let error = UIColor.systemRed
        static let warning = UIColor.systemOrange
        static let info = UIColor.systemBlue
        
        // UI Element Colors
        static let border = UIColor.separator
        static let separator = UIColor.separator
        static let shadow = UIColor.black.withAlphaComponent(0.1)
        
        // Semantic Colors (for different app types)
        // Bank App
        static let debit = UIColor.systemRed
        static let credit = UIColor.systemGreen
        
        // School App
        static let gradeA = UIColor.systemGreen
        static let gradeB = UIColor.systemBlue
        static let gradeC = UIColor.systemOrange
        static let gradeF = UIColor.systemRed
    }
    
    // MARK: - Typography
    struct Typography {
        // Headings
        static let largeTitle = UIFont.systemFont(ofSize: 34, weight: .bold)
        static let title1 = UIFont.systemFont(ofSize: 28, weight: .bold)
        static let title2 = UIFont.systemFont(ofSize: 22, weight: .bold)
        static let title3 = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        // Body
        static let body = UIFont.systemFont(ofSize: 17, weight: .regular)
        static let bodyBold = UIFont.systemFont(ofSize: 17, weight: .semibold)
        static let callout = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        // Small Text
        static let subheadline = UIFont.systemFont(ofSize: 15, weight: .regular)
        static let footnote = UIFont.systemFont(ofSize: 13, weight: .regular)
        static let caption1 = UIFont.systemFont(ofSize: 12, weight: .regular)
        static let caption2 = UIFont.systemFont(ofSize: 11, weight: .regular)
        
        // Legacy support (for backward compatibility)
        static func appHeading1() -> UIFont { return title1 }
        static func appHeading2() -> UIFont { return title2 }
        static func appHeading3() -> UIFont { return title3 }
        static func appBody() -> UIFont { return body }
        static func appBodyBold() -> UIFont { return bodyBold }
        static func appCaption() -> UIFont { return caption1 }
        static func appCaptionBold() -> UIFont { return UIFont.systemFont(ofSize: 12, weight: .semibold) }
    }
    
    // MARK: - Spacing
    struct Spacing {
        static let extraSmall: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 32
        static let huge: CGFloat = 48
        
        // Legacy support
        static let xs = extraSmall
        static let sm = small
        static let md = medium
        static let lg = large
        static let xl = extraLarge
        static let xxl = huge
    }
    
    // MARK: - Layout
    struct Layout {
        static let cornerRadius: CGFloat = 12
        static let smallCornerRadius: CGFloat = 8
        static let largeCornerRadius: CGFloat = 16
        
        static let borderWidth: CGFloat = 1
        static let thickBorderWidth: CGFloat = 2
        
        static let buttonHeight: CGFloat = 50
        static let textFieldHeight: CGFloat = 50
        static let iconSize: CGFloat = 24
        static let largeIconSize: CGFloat = 48
        
        static let cardPadding: CGFloat = 16
        static let screenPadding: CGFloat = 16
    }
    
    // MARK: - Shadow
    struct Shadow {
        static func apply(to layer: CALayer, style: ShadowStyle = .default) {
            layer.shadowColor = style.color.cgColor
            layer.shadowOffset = style.offset
            layer.shadowRadius = style.radius
            layer.shadowOpacity = style.opacity
        }
        
        enum ShadowStyle {
            case none
            case `default`
            case medium
            case large
            
            var color: UIColor {
                return Colors.shadow
            }
            
            var offset: CGSize {
                switch self {
                case .none: return .zero
                case .default: return CGSize(width: 0, height: 2)
                case .medium: return CGSize(width: 0, height: 4)
                case .large: return CGSize(width: 0, height: 8)
                }
            }
            
            var radius: CGFloat {
                switch self {
                case .none: return 0
                case .default: return 4
                case .medium: return 8
                case .large: return 16
                }
            }
            
            var opacity: Float {
                switch self {
                case .none: return 0
                case .default: return 0.1
                case .medium: return 0.15
                case .large: return 0.2
                }
            }
        }
    }
    
    // MARK: - Animation
    struct Animation {
        static let defaultDuration: TimeInterval = 0.3
        static let shortDuration: TimeInterval = 0.2
        static let longDuration: TimeInterval = 0.5
        
        static let springDamping: CGFloat = 0.8
        static let springVelocity: CGFloat = 0.5
        
        static func animate(
            duration: TimeInterval = defaultDuration,
            animations: @escaping () -> Void,
            completion: ((Bool) -> Void)? = nil
        ) {
            UIView.animate(
                withDuration: duration,
                delay: 0,
                usingSpringWithDamping: springDamping,
                initialSpringVelocity: springVelocity,
                options: [.curveEaseInOut],
                animations: animations,
                completion: completion
            )
        }
    }
}

