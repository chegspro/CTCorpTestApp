//
//  AppDelegate.swift
//  CTCorpGithub
//
//  Created by Aslam Azis on 20/11/20.
//

import UIKit
import CTCorpAPI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        showInitialScreen()
        return true
    }

    private func showInitialScreen() {
        let view = SearchUsersRouter.buildModule()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = view
        window?.makeKeyAndVisible()
    }
    
    private func initAPIConfiguration() {
        let config = Configuration()
        config.debuggable = true
        CTCorpAPI.shared.config = config
    }

}

