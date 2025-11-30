//
//  NetworkError.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import Foundation
import Moya

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError(Error)
    case httpError(statusCode: Int)
    case moyaError(MoyaError)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .httpError(let statusCode):
            return "HTTP error with status code: \(statusCode)"
        case .moyaError(let error):
            return error.localizedDescription
        case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
}

