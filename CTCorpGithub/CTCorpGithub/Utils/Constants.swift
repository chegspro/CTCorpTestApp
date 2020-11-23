//
//  Constants.swift
//  CTCorpGithub
//
//  Created by Aslam Azis on 20/11/20.
//

import Foundation

class Constants {
    
    static let sortByItems = [
        FilterItem(text: "Followers", tag: "followers"),
        FilterItem(text: "Repositories", tag: "repositories"),
        FilterItem(text: "Joined", tag: "joined"),
        FilterItem(text: "Default (Sort Order ignored)", tag: "", isSelected: true)
    ]
    
    static let sortOrderItems = [
        FilterItem(text: "Ascending", tag: "asc"),
        FilterItem(text: "Descending", tag: "desc", isSelected: true)
    ]
    
}
