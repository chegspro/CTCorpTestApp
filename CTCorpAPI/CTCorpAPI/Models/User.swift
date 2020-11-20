//
//  User.swift
//  CTCorpAPI
//
//  Created by Aslam Azis on 19/11/20.
//

import Foundation

public class User: Codable {
    public let login: String
    public let id: Int
    public let nodeID: String
    public let avatarURL: String
    public let gravatarID: String
    public let url, htmlURL, followersURL: String
    public let followingURL, gistsURL, starredURL: String
    public let subscriptionsURL, organizationsURL, reposURL: String
    public let eventsURL: String
    public let receivedEventsURL: String
    public let type: String
    public let siteAdmin: Bool
    public let score: Int
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        case score
    }
    
    public init(login: String, id: Int, nodeID: String, avatarURL: String, gravatarID: String, url: String, htmlURL: String, followersURL: String, followingURL: String, gistsURL: String, starredURL: String, subscriptionsURL: String, organizationsURL: String, reposURL: String, eventsURL: String, receivedEventsURL: String, type: String, siteAdmin: Bool, score: Int) {
        self.login = login
        self.id = id
        self.nodeID = nodeID
        self.avatarURL = avatarURL
        self.gravatarID = gravatarID
        self.url = url
        self.htmlURL = htmlURL
        self.followersURL = followersURL
        self.followingURL = followingURL
        self.gistsURL = gistsURL
        self.starredURL = starredURL
        self.subscriptionsURL = subscriptionsURL
        self.organizationsURL = organizationsURL
        self.reposURL = reposURL
        self.eventsURL = eventsURL
        self.receivedEventsURL = receivedEventsURL
        self.type = type
        self.siteAdmin = siteAdmin
        self.score = score
    }
}
