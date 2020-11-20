//
//  UserRequest.swift
//  CTCorpAPI
//
//  Created by Aslam Azis on 19/11/20.
//

import Foundation

public class SearchUsersRequest: BaseRequest {
    
    public typealias DataResponse = SearchUsersResponse
    
    let path = "/search/users"
    
    public init() {}
    
    public func searchUsers(query: SearchUserQuery, page: Int = 0, pageSize: Int = 20, completion: @escaping (BaseResult<DataResponse>) -> ()) -> URLSessionTask? {
        
        var params = query.toParams()
        params["page"] = "\(page)"
        params["per_page"] = "\(pageSize)"
        print(params)
        return request(method: .GET, path: path, pathParams: params) { (result) in
            completion(result)
        }
        
    }
    
}
