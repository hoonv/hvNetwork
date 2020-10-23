//
//  File.swift
//  
//
//  Created by 채훈기 on 2020/10/23.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
    
    static let contentType = "Content-Type"
    static let contentTypeValue = "application/json"
    
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            
            if urlRequest.value(forHTTPHeaderField: contentType) == nil {
                urlRequest.setValue(contentTypeValue, forHTTPHeaderField: contentType)
            }
        }catch {
            throw NetworkError.encodingFailed
        }
    }
}
