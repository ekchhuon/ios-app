//
//  UIView+Extensions.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func roundCorners(_ radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func addShadow(color: UIColor = .black, opacity: Float = 0.1, offset: CGSize = .zero, radius: CGFloat = 10) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
}

