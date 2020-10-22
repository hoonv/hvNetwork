//
//  NetworkRouter.swift
//  hvNetwork
//
//  Created by 채훈기 on 2020/10/21.
//

import Foundation

public typealias TaskCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?)->()
public typealias DownloadTaskCompletion = (_ url: URL?, _ response: URLResponse?, _ error: Error?) -> ()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping TaskCompletion)
    func download(_ route: EndPoint, completion: @escaping DownloadTaskCompletion)
    func cancel()
    func downloadCancel()
}

public class Router<EndPoint: EndPointType>: NetworkRouter {
    
    private var task: URLSessionTask?
    private var downloadTask: URLSessionDownloadTask?
    private let session = URLSession.shared

    public init() {
        
    }
    
    public func request(_ route: EndPoint, completion: @escaping TaskCompletion) {
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    public func download(_ route: EndPoint, completion: @escaping DownloadTaskCompletion) {
        do {
            let request = try self.buildRequest(from: route)

            downloadTask = session.downloadTask(with: request, completionHandler: { url, response, error in
                completion(url, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.downloadTask?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    func downloadCancel() {
        self.downloadTask?.cancel()
    }

    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var url = route.baseURL
        
        if let path = route.path {
            url = url.appendingPathComponent(path)
        }
        
        var request = URLRequest(url: url,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        switch route.task {
        case .request, .download:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .requestParameters(let bodyParameters, let urlParameters),
             .downloadParameters(let bodyParameters, let urlParameters):
            try self.configureParameters(bodyParameters: bodyParameters,
                                         urlParameters: urlParameters,
                                         request: &request)
        }
        return request
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
}
