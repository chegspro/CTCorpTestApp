//
//  BaseResult.swift
//  CTCorpAPI
//
//  Created by Aslam Azis on 19/11/20.
//

import Foundation

public struct BaseResult<T> {
    public let code: Int
    public let data: T?
    public let message: String
}
