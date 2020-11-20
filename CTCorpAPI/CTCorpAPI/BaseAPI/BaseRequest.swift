//
//  BaseRequest.swift
//  CTCorpAPI
//
//  Created by Aslam Azis on 19/11/20.
//

import Foundation

public protocol BaseRequest {
    associatedtype DataResponse: Decodable
}

extension BaseRequest {
    
    public func request(method: HTTPMethod, path: String, pathParams: [String: String]? = nil, completion: @escaping ((BaseResult<DataResponse>) -> ())) -> URLSessionDataTask? {
        if !Reachability.isConnectedToNetwork() {
            completion(BaseResult(code: 998, data: nil, message: "No internet connection"))
        }
        
        let url = "\(CTCorpAPI.shared.config.baseURL)\(path)"
        
        guard var components = URLComponents(string: url) else {
            completion(BaseResult(code: 999, data: nil, message: "Invalid URL path"))
            return nil
        }
        if let params = pathParams {
            components.queryItems = params.map({ URLQueryItem(name: $0, value: $1)})
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        
        Logger.log("debug - Request : \(request.url!)")
        
        let task = CTCorpAPI.shared.session.dataTask(with: request) { data, response, error in
            if let error = error, response == nil {
                completion(BaseResult(code: 999, data: nil, message: error.localizedDescription))
            } else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 500
                
                if let data = data {
                    let strResponse = String(data: data, encoding: .utf8)
                    Logger.log("debug Response : \(strResponse ?? "No Response")")
                    
                    do {
                        let dataResponse = try JSONDecoder().decode(DataResponse.self, from: data)
                        completion(BaseResult(code: statusCode, data: dataResponse, message: "Success"))
                    } catch {
                        do {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                            completion(BaseResult(code: statusCode, data: nil, message: errorResponse.message))
                        } catch {
                            print(error)
                            completion(BaseResult(code: statusCode, data: nil, message: "Server Error"))
                        }
                    }
                } else {
                    completion(BaseResult(code: statusCode, data: nil, message: "Server Error"))
                }
            }
        }
        task.resume()
        return task
    }
    
}

public enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
}
