//
//	SearchUsersPresenter.swift
// 	CTCorpGithub
//
//	
//

import Foundation
import CTCorpAPI

class SearchUsersPresenter {
	
    var users: [User]?
    var currentQuery = SearchUserQuery()
    
	private var view: SearchUsersViewProtocol?
    private var interactor: SearchUsersInteractorProtocol?
    private var page: Int = 0
    private var isLoading = false
    private let pageSize = 20
    private var hasMore = false

    init(view: SearchUsersViewProtocol, interactor: SearchUsersInteractorProtocol) {
		self.view = view
        self.interactor = interactor
	}

	//MARK: - Privates
    private func fetchData() {
        guard !isLoading else { return }
        isLoading = true
        view?.showLoading(show: true)
        interactor?.cancelRequest()
        interactor?.searchUsers(query: currentQuery, page: page, pageSize: pageSize)
    }
    
}

//MARK: - SearchUsersPresenterProtocol
extension SearchUsersPresenter: SearchUsersPresenterProtocol {
    
    func searchUsers(keyword: String) {
        currentQuery.keyword = keyword
        page = 0
        fetchData()
    }
    
    func loadNextPage() {
        guard hasMore else { return }
        fetchData()
    }
    
    func reload() {
        page = 0
        fetchData()
    }
    
    func clearData() {
        interactor?.cancelRequest()
        users?.removeAll()
        view?.reloadData(showEmptyState: false)
    }
    
    func searchWithFilter(sortBy: FilterItem, sortOrder: FilterItem) {
        currentQuery.sort = sortBy.tag
        currentQuery.order = sortOrder.tag
        if currentQuery.keyword?.count ?? 0 > 0 {
            page = 0
            fetchData()
        }
    }
	
}

//MARK: - SearchUsersInteractorOutputProtocol
extension SearchUsersPresenter: SearchUsersInteractorOutputProtocol {
    func didSuccessSearchUsers(users: [User], totalItems: Int) {
        view?.showLoading(show: false)
        if page == 0 {
            self.users = users
        } else {
            self.users?.append(contentsOf: users)
        }
        hasMore = self.users?.count ?? 0 < totalItems
        if hasMore {
            page += 1
        }
        view?.reloadData(showEmptyState: true)
        isLoading = false
    }
    
    func didFailedSearchUsers(code: Int, message: String) {
        view?.showLoading(show: false)
        view?.showAlert(message: message)
        isLoading = false
    }
}
