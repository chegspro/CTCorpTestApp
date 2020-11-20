//
//  CTCorpAPI.swift
//  CTCorpAPI
//
//  Created by Aslam Azis on 19/11/20.
//

import Foundation

public class CTCorpAPI {
    
    public static let shared = CTCorpAPI()
    
    public var config = Configuration()
    var session = URLSession.shared
    
    public func setConfig(_ config: Configuration) {
        self.config = config
    }
    
    public func invalidateSession() {
        session.invalidateAndCancel()
    }
}
