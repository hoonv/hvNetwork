//
//  HTTPTask.swift
//  hvNetwork
//
//  Created by 채훈기 on 2020/10/21.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request
    
    case download

    case requestParameters(bodyParameters: Parameters?,
                           urlParameters: Parameters?)
        
    case downloadParameters(bodyParameters: Parameters?,
                            urlParameters: Parameters?)
}
