//
//  File.swift
//  
//
//  Created by 채훈기 on 2020/10/23.
//

import Foundation

public protocol URLConvertible {
    
    func asURL() throws -> URL
}

extension String: URLConvertible {
    
    public func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw NetworkError.missingURL }
        return url
    }
}

extension URL: URLConvertible {
    
    public func asURL() throws -> URL {
        return self
    }
}
