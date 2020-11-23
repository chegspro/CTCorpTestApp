//
//  SearchUsersRouter.swift
//  CTCorpGithub
//
//  Created by Aslam Azis on 20/11/20.
//

import Foundation

class SearchUsersRouter {
    
    static func buildModule() -> SearchUsersVC {
        let view = SearchUsersVC(nibName: "SearchUsers", bundle: nil)
        let interactor = SearchUsersInteractor()
        let presenter = SearchUsersPresenter(view: view, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
    
}
