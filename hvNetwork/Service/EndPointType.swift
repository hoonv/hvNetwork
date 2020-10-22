//
//  EndPointType.swift
//  hvNetwork
//
//  Created by 채훈기 on 2020/10/21.
//

import Foundation

public protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
