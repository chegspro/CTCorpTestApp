//
//  Logger.swift
//  CTCorpAPI
//
//  Created by Aslam Azis on 19/11/20.
//

import Foundation

public class Logger {
    
    public static func log(_ args: Any...) {
        if CTCorpAPI.shared.config.debuggable {
            print(args)
        }
    }
    
}
