//
//  HVNetwork.swift
//  hvNetwork
//
//  Created by 채훈기 on 2020/10/22.
//

import Foundation

public class HVNetwork {
    
    public static let shared = HVNetwork()
    
    private init() {
        
    }
    
    private struct MockEndPoint: EndPointType {
        var baseURL: URL
        var path: String?
        var httpMethod: HTTPMethod
        var task: HTTPTask
        var headers: HTTPHeaders?
    }
    
    public func dataTask<T: Decodable>(_ url: String,
                                       path: String? = nil,
                                       method: HTTPMethod,
                                       task: HTTPTask,
                                       header: HTTPHeaders? = nil,
                                       completion: @escaping (Result<T,NetworkError>) -> Void) {
        guard let url = URL(string: url) else { return completion(.failure(.missingURL))}

        let mock = MockEndPoint(baseURL: url, path: path, httpMethod: method, task: task, headers: header)
        
        let router = Router<MockEndPoint>()
        router.request(mock) { (data, response, error) in
            guard let data = data else {
                return completion(.failure(.missingData))
            }
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
    }
    
    public func dataTask(_ url: String,
                         path: String? = nil,
                         method: HTTPMethod,
                         task: HTTPTask,
                         header: HTTPHeaders? = nil) {
        guard let url = URL(string: url) else { return }

        let mock = MockEndPoint(baseURL: url, path: path, httpMethod: method, task: task, headers: header)
        
        let router = Router<MockEndPoint>()
        router.request(mock) { (data, response, error) in
            return
        }
    }
}
