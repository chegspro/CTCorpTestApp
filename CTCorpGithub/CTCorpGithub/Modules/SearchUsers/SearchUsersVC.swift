//
//	SearchUsersVC.swift
// 	CTCorpGithub
//
//	
//


import UIKit

class SearchUsersVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var presenter: SearchUsersPresenterProtocol?
    
    private var timer: Timer? = nil
    private var refreshControl = UIRefreshControl()
    private var cellIdentifier = "SearchUsersCell"
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setupViews()
    }
    
    
    //MARK: - Privates
    private func setupViews() {
        searchBar.delegate = self
        refreshControl.addTarget(self, action: #selector(self.reload), for: .valueChanged)
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
    }
    
    private func showNoResult() {
        let emptyView = EmptyStateView()
        emptyView.populate(image: UIImage(named: "search_error")!, title: "No result", subtitle: "No users found with given keyword")
        tableView.backgroundView = emptyView
    }
    
    private func removeTableViewBackground() {
        tableView.backgroundView = UIView()
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.searchUsers), userInfo: nil, repeats: false)
    }
    
    //MARK: - IBActions
    @IBAction func showFilter(_ sender: Any) {
        let filterDialog = SearchFilterDialog()
        filterDialog.setItems(sortByItems: Constants.sortByItems, sortOrderItems: Constants.sortOrderItems, selectedSortBy: presenter?.currentQuery.sort, selectedSortOrder: presenter?.currentQuery.order)
        filterDialog.delegate = self
        filterDialog.modalTransitionStyle = .crossDissolve
        filterDialog.modalPresentationStyle = .overFullScreen
        present(filterDialog, animated: false)
    }
    
    //MARK: - objcs
    @objc func searchUsers() {
        if let keyword = searchBar.text {
            if keyword.count > 0 {
                presenter?.searchUsers(keyword: keyword)
            } else {
                presenter?.clearData()
            }
        }
    }
    
    @objc func reload() {
        if refreshControl.isRefreshing { refreshControl.endRefreshing() }
        presenter?.reload()
    }
}

//MARK: - UITableViewDelegate
extension SearchUsersVC: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let itemsCount = presenter?.users?.count else { return }
        if let visibleRows = tableView.indexPathsForVisibleRows,
           let bottomIndex = visibleRows.last,
           itemsCount - bottomIndex.row < 2
        {
            presenter?.loadNextPage()
        }
    }
}

//MARK: - UITableViewDataSource
extension SearchUsersVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! SearchUsersCell
        guard let users = presenter?.users else { return cell }
        if indexPath.row < users.count {
            let user = users[indexPath.row]
            cell.populate(user: user)
        }
        return cell
    }
}

//MARK: - SearchUsersViewProtocol
extension SearchUsersVC: SearchUsersViewProtocol {
    func showLoading(show: Bool) {
        DispatchQueue.main.async { [unowned self] in
            ProgressView.shared.show(show: show, view: self.view)
        }
    }
    
    func showAlert(message: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self?.present(alert, animated: true)
        }
    }
    
    func reloadData(showEmptyState: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            if self?.presenter?.users?.count ?? 0 == 0 && showEmptyState {
                self?.showNoResult()
            } else {
                self?.removeTableViewBackground()
            }
        }
    }
}

//MARK: - UISearchBarDelegate
extension SearchUsersVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        startTimer()
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        stopTimer()
        return true
    }
}

//MARK: - SearchFilterDelegate
extension SearchUsersVC: SearchFilterDelegate {
    func didApplyFilter(sortBy: FilterItem, orderBy: FilterItem) {
        presenter?.searchWithFilter(sortBy: sortBy, sortOrder: orderBy)
    }
}
