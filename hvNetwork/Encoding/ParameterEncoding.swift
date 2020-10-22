//
//  ParameterEncoding.swift
//  hvNetwork
//
//  Created by 채훈기 on 2020/10/21.
//

import Foundation

public typealias Parameters = [String:Any]

public protocol ParameterEncoder {
    
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
    case missingURLComponent = "URLComponent is nil"
}
