//
//  SearchUserResponse.swift
//  CTCorpAPI
//
//  Created by Aslam Azis on 19/11/20.
//

import Foundation

public struct SearchUsersResponse: Decodable {
    public let totalCount: Int
    public let items: [User]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
    
    init(totalCount: Int, items: [User]) {
        self.totalCount = totalCount
        self.items = items
    }
}
