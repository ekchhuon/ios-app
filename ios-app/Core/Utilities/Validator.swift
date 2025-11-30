//
//  Validator.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import Foundation

struct Validator {
    /// Validate email format
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    /// Validate phone number (basic validation)
    static func isValidPhone(_ phone: String) -> Bool {
        let phoneRegex = "^[0-9]{8,15}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phone.replacingOccurrences(of: " ", with: ""))
    }
    
    /// Validate password strength
    static func isValidPassword(_ password: String, minLength: Int = 8) -> Bool {
        return password.count >= minLength
    }
    
    /// Validate strong password (at least 8 chars, 1 uppercase, 1 lowercase, 1 number)
    static func isStrongPassword(_ password: String) -> Bool {
        guard password.count >= 8 else { return false }
        
        let uppercaseRegex = ".*[A-Z]+.*"
        let lowercaseRegex = ".*[a-z]+.*"
        let numberRegex = ".*[0-9]+.*"
        
        let uppercasePredicate = NSPredicate(format: "SELF MATCHES %@", uppercaseRegex)
        let lowercasePredicate = NSPredicate(format: "SELF MATCHES %@", lowercaseRegex)
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        
        return uppercasePredicate.evaluate(with: password) &&
               lowercasePredicate.evaluate(with: password) &&
               numberPredicate.evaluate(with: password)
    }
    
    /// Validate not empty
    static func isNotEmpty(_ string: String) -> Bool {
        return !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    /// Validate minimum length
    static func hasMinimumLength(_ string: String, length: Int) -> Bool {
        return string.count >= length
    }
    
    /// Validate maximum length
    static func hasMaximumLength(_ string: String, length: Int) -> Bool {
        return string.count <= length
    }
    
}

