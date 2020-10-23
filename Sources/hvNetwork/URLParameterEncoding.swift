//
//  File.swift
//  
//
//  Created by 채훈기 on 2020/10/23.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    
    static let contentType = "Content-Type"
    static let contentTypeValue = "application/x-www-form-urlencoded; charset=utf-8"
    
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { throw NetworkError.missingURLComponent }
        if parameters.isEmpty { return }
        
        urlComponents.queryItems = [URLQueryItem]()
        
        for (key,value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
            urlComponents.queryItems?.append(queryItem)
        }
        
        urlRequest.url = urlComponents.url
        
        
        if urlRequest.value(forHTTPHeaderField: contentType) == nil {
            urlRequest.setValue(contentTypeValue, forHTTPHeaderField: contentType)
        }
    }
}
