//
//  DateFormatter+Shared.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import Foundation

extension DateFormatter {
    /// Shared date formatter for common formats
    static let shared: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        return formatter
    }()
    
    /// Short date format (e.g., "Jan 1, 2024")
    static var shortDate: DateFormatter {
        let formatter = shared
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }
    
    /// Medium date format (e.g., "Jan 1, 2024")
    static var mediumDate: DateFormatter {
        let formatter = shared
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    /// Long date format (e.g., "January 1, 2024")
    static var longDate: DateFormatter {
        let formatter = shared
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }
    
    /// Time format (e.g., "3:30 PM")
    static var time: DateFormatter {
        let formatter = shared
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }
    
    /// Date and time format (e.g., "Jan 1, 2024 at 3:30 PM")
    static var dateTime: DateFormatter {
        let formatter = shared
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    /// ISO 8601 format
    static var iso8601: DateFormatter {
        let formatter = shared
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }
    
    /// Custom format
    static func custom(format: String) -> DateFormatter {
        let formatter = shared
        formatter.dateFormat = format
        return formatter
    }
}

