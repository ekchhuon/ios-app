//
//  APIClient.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import Foundation
import Moya
import Alamofire

protocol APIClientProtocol {
    func request<T: TargetType>(_ target: T, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

class APIClient: APIClientProtocol {
    static let shared = APIClient()
    
    private let provider: MoyaProvider<MultiTarget>
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = AppConfig.defaultTimeout
        configuration.timeoutIntervalForResource = AppConfig.defaultTimeout
        
        let session = Session(configuration: configuration)
        
        #if DEBUG
        let plugins: [PluginType] = [NetworkLoggerPlugin()]
        #else
        let plugins: [PluginType] = []
        #endif
        
        provider = MoyaProvider<MultiTarget>(
            session: session,
            plugins: plugins
        )
    }
    
    func request<T: TargetType>(_ target: T, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        provider.request(MultiTarget(target)) { result in
            switch result {
            case .success(let response):
                if (200...299).contains(response.statusCode) {
                    completion(.success(response.data))
                } else {
                    completion(.failure(NetworkError.httpError(statusCode: response.statusCode)))
                }
            case .failure(let error):
                completion(.failure(NetworkError.moyaError(error)))
            }
        }
    }
}

