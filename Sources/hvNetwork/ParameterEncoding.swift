//
//  File.swift
//  
//
//  Created by 채훈기 on 2020/10/23.
//

import Foundation

public typealias Parameters = [String:Any]

public protocol ParameterEncoder {
    
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case decodingFailed = "Parameter decoding failed."
    case missingURL = "URL is nil."
    case missingURLComponent = "URLComponent is nil"
    case missingData = "data is nil"
}
