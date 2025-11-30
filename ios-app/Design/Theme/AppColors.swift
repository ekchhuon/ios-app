//
//  AppColors.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//
//  Legacy color support - maps to AppTheme.Colors for backward compatibility

import UIKit

extension UIColor {
    // Primary Colors
    static let appPrimary = AppTheme.Colors.primary
    static let appSecondary = AppTheme.Colors.secondary
    
    // Semantic Colors
    static let appBackground = AppTheme.Colors.background
    static let appSecondaryBackground = AppTheme.Colors.backgroundSecondary
    static let appTertiaryBackground = AppTheme.Colors.backgroundTertiary
    
    // Text Colors
    static let appPrimaryText = AppTheme.Colors.textPrimary
    static let appSecondaryText = AppTheme.Colors.textSecondary
    static let appTertiaryText = AppTheme.Colors.textTertiary
    
    // Accent Colors
    static let appSuccess = AppTheme.Colors.success
    static let appWarning = AppTheme.Colors.warning
    static let appError = AppTheme.Colors.error
    static let appInfo = AppTheme.Colors.info
}

