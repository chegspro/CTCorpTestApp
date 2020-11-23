//
//	SearchUsersContract.swift
// 	CTCorpGithub
//
//	
//
import CTCorpAPI

protocol SearchUsersViewProtocol {
	
    func showLoading(show: Bool)
    func reloadData(showEmptyState: Bool)
    func showAlert(message: String)
    
}

protocol SearchUsersPresenterProtocol {
	
    var users: [User]? { get set }
    var currentQuery: SearchUserQuery { get }
    
    func searchUsers(keyword: String)
    func loadNextPage()
    func reload()
    func clearData()
    func searchWithFilter(sortBy: FilterItem, sortOrder: FilterItem)
	
}

protocol SearchUsersInteractorOutputProtocol {
    func didSuccessSearchUsers(users: [User], totalItems: Int)
    func didFailedSearchUsers(code: Int, message: String)
}

protocol SearchUsersInteractorProtocol {
    func searchUsers(query: SearchUserQuery, page: Int, pageSize: Int)
    func cancelRequest()
}
