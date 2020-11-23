//
//  SearchUsersInteractor.swift
//  CTCorpGithub
//
//  Created by Aslam Azis on 20/11/20.
//

import Foundation
import CTCorpAPI

class SearchUsersInteractor: SearchUsersInteractorProtocol {
    
    var output: SearchUsersInteractorOutputProtocol?
    
    private var currentTask: URLSessionTask?
    
    func searchUsers(query: SearchUserQuery, page: Int, pageSize: Int) {
        let task = SearchUsersRequest().searchUsers(query: query, page: page, pageSize: pageSize) { [weak self] (result) in
            if result.code <= 200, let users = result.data?.items {
                self?.output?.didSuccessSearchUsers(users: users, totalItems: result.data?.totalCount ?? 0)
            } else {
                self?.output?.didFailedSearchUsers(code: result.code, message: result.message)
            }
            self?.currentTask = nil
        }
        currentTask = task
    }
    
    func cancelRequest() {
        currentTask?.cancel()
    }
    
}
