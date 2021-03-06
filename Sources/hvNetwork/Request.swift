//
//  File.swift
//  
//
//  Created by 채훈기 on 2020/10/23.
//

import Foundation

public typealias HVDataResponse<Success> = Result<Success, NetworkError>
public typealias HTTPHeaders = [String:String]
public typealias JSON = [String:Any]

open class DataRequest {
    
    private let urlConvertible: URLConvertible
    private let method: HTTPMethod
    private let parameters: Parameters?
    private let headers: HTTPHeaders?
    
    public init(url: URLConvertible,
                method: HTTPMethod,
                parameters: Parameters?,
                headers: HTTPHeaders?) {
        self.urlConvertible = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
    
    public func response(completionHandler: @escaping (HVDataResponse<Data?>) -> Void) {
        do {
            let request = try buildRequest()
            
            URLSession.shared.dataTask(with: request, completionHandler: {
                (data, response, error) in
                completionHandler(.success(data))
            }).resume()
        } catch {
            completionHandler(.failure(.missingURL))
        }
    }
    
    public func response(completionHandler: @escaping (HVDataResponse<JSON>) -> Void) {
        do {
            let request = try buildRequest()
            
            URLSession.shared.dataTask(with: request, completionHandler: {
                (data, response, error) in
                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data, options: []) as? JSON else { completionHandler(.failure(.decodingFailed)); return  }
                completionHandler(.success(json))
            }).resume()
        } catch {
            completionHandler(.failure(.missingURL))
        }
    }
    
    fileprivate func buildRequest() throws -> URLRequest {
        do {
            var request = try URLRequest(url: urlConvertible.asURL(), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
            request.httpMethod = method.rawValue
            headers?.forEach { key, value in
                request.setValue(value, forHTTPHeaderField: key)
            }
            if request.value(forHTTPHeaderField: "Content-Type") == nil {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            if let parameters = self.parameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: parameters)
                return request
            }
            return request
        } catch {
            throw error
        }
    }
}

open class DataRequestAsDecodable<T:Decodable>: DataRequest {
    
    public func response(completionHandler: @escaping (HVDataResponse<T>) -> Void) {
        do {
            let request = try buildRequest()
            URLSession.shared.dataTask(with: request, completionHandler: {
                (data, response, error) in
                guard let data = data else {
                    return completionHandler(.failure(.missingData))
                }
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(model))
                } catch {
                    completionHandler(.failure(.decodingFailed))
                }
            }).resume()
        } catch {
            completionHandler(.failure(.missingURL))
        }
    }
}

open class DownLoadRequest: DataRequest {
    
    public func response(completionHandler: @escaping () -> Void) {
        
    }
}
