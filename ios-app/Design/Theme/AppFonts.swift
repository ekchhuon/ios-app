//
//  AppFonts.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import UIKit

extension UIFont {
    // Headings
    static func appHeading1() -> UIFont {
        return .systemFont(ofSize: 32, weight: .bold)
    }
    
    static func appHeading2() -> UIFont {
        return .systemFont(ofSize: 24, weight: .bold)
    }
    
    static func appHeading3() -> UIFont {
        return .systemFont(ofSize: 20, weight: .semibold)
    }
    
    // Body
    static func appBody() -> UIFont {
        return .systemFont(ofSize: 16, weight: .regular)
    }
    
    static func appBodyBold() -> UIFont {
        return .systemFont(ofSize: 16, weight: .semibold)
    }
    
    // Caption
    static func appCaption() -> UIFont {
        return .systemFont(ofSize: 14, weight: .regular)
    }
    
    static func appCaptionBold() -> UIFont {
        return .systemFont(ofSize: 14, weight: .semibold)
    }
}

