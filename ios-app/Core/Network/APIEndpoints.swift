//
//  APIEndpoints.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import Foundation
import Moya
import Alamofire


enum APIEndpoints {
    case login(email: String, password: String)
    case logout
    case getUserProfile
    case updateProfile(data: [String: Any])
}

extension APIEndpoints: TargetType {
    var baseURL: URL {
        return URL(string: AppConfig.baseURL)!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .logout:
            return "/auth/logout"
        case .getUserProfile:
            return "/user/profile"
        case .updateProfile:
            return "/user/profile"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .updateProfile:
            return .post
        case .logout:
            return .post
        case .getUserProfile:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(
                parameters: ["email": email, "password": password],
                encoding: JSONEncoding.default
            )
        case .logout:
            return .requestPlain
        case .getUserProfile:
            return .requestPlain
        case .updateProfile(let data):
            return .requestParameters(parameters: data, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        var headers: [String: String] = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        // Add auth token if available
        if let token = AuthManager.shared.getAccessToken() {
            headers["Authorization"] = "Bearer \(token)"
        }
        
        return headers
    }
    
    var sampleData: Data {
        return Data()
    }
}

