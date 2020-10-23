//
//  File.swift
//  
//
//  Created by 채훈기 on 2020/10/23.
//

import Foundation

public class Session {
    
    public static let shared = Session()
    
    private init() {
        
    }
    
    public func request(_ convertible: URLConvertible,
                        method: HTTPMethod = .get,
                        parameter: Parameters? = nil,
                        headers: HTTPHeaders? = nil) -> DataRequest {
        
        return DataRequest(url: convertible,
                           method: method,
                           parameters: parameter,
                           headers: headers)
    }
    
    public func request<T: Decodable>(_ convertible: URLConvertible,
                                      method: HTTPMethod = .get,
                                      parameter: Parameters? = nil,
                                      headers: HTTPHeaders? = nil) -> DataRequestAsDecodable<T> {
        
        return DataRequestAsDecodable<T>(url: convertible,
                                      method: method,
                                      parameters: parameter,
                                      headers: headers)
    }
    
    public func download(_ convertible: URLConvertible,
                         method: HTTPMethod = .get,
                         parameter: Parameters? = nil,
                         headers: HTTPHeaders? = nil) -> DataRequest {
        
        return DataRequest(url: convertible,
                           method: method,
                           parameters: parameter,
                           headers: headers)
    }
}
