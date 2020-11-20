//
//  SearchUserQuery.swift
//  CTCorpAPI
//
//  Created by Aslam Azis on 20/11/20.
//

import Foundation

public class SearchUserQuery {
    
    public var keyword: String?
    public var sort: String?
    public var order: String?
    
    public init() {}
    
    func toParams() -> [String : String] {
        var params = [String : String]()
        if let keyword = self.keyword {
            params["q"] = keyword
        }
        if let sort = self.sort {
            params["sort"] = sort
        }
        if let order = self.order {
            params["order"] = order
        }
        return params
    }
}
