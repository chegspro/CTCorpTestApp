//
//	SearchFilterDialog.swift
//	CTCorpGithub
//
//	
//

import UIKit

class SearchFilterDialog: UIViewController {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var constHeightCVSortBy: NSLayoutConstraint!
    @IBOutlet weak var constHeightCVSortOrder: NSLayoutConstraint!
    @IBOutlet weak var cvSortBy: UICollectionView!
    @IBOutlet weak var cvSortOrder: UICollectionView!
    
    var delegate: SearchFilterDelegate?
    
    private var sortByItems = [FilterItem]()
    private var sortOrderItems = [FilterItem]()
    private var cellIdentifier = "SearchFilterCell"
    private var layoutSortBy: SearchFilterFlowLayout = {
        let layout = SearchFilterFlowLayout(minimumInteritemSpacing: 8, minimumLineSpacing: 8)
        return layout
    }()
    private var layoutSortOrder: SearchFilterFlowLayout = {
        let layout = SearchFilterFlowLayout(minimumInteritemSpacing: 8, minimumLineSpacing: 8)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showContent()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if object as? UICollectionView == self.cvSortBy {
                    self.constHeightCVSortBy.constant = self.cvSortBy.contentSize.height
                    self.view.layoutIfNeeded()
                } else if object as? UICollectionView == self.cvSortBy {
                    self.constHeightCVSortOrder.constant = self.cvSortOrder.contentSize.height
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    func setItems(sortByItems: [FilterItem], sortOrderItems: [FilterItem], selectedSortBy: String? = nil, selectedSortOrder: String? = nil) {
        self.sortByItems = sortByItems
        self.sortOrderItems = sortOrderItems
        guard let sSortBy = selectedSortBy else { return }
        guard let indexSortBy = self.sortByItems.firstIndex(where: { $0.tag == sSortBy }) else { return }
        clearSortBySelection()
        self.sortByItems[indexSortBy].isSelected = true
        
        guard let sOrderBy = selectedSortOrder else { return }
        guard let indexSortOrder = self.sortOrderItems.firstIndex(where: { $0.tag == sOrderBy }) else { return }
        clearSortOrderSelection()
        self.sortOrderItems[indexSortOrder].isSelected = true
    }
    
    private func setupViews() {
        contentView.alpha = 0
        contentView.transform = CGAffineTransform(translationX: 0, y: 50.0)
        contentView.layer.cornerRadius = 8
        setupCollectionViews()
    }
    
    private func setupCollectionViews() {
        cvSortBy.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        cvSortOrder.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        cvSortBy.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        cvSortOrder.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        cvSortBy.collectionViewLayout = layoutSortBy
        cvSortOrder.collectionViewLayout = layoutSortOrder
    }
    
    private func showContent() {
        UIView.animate(withDuration: 0.33) { [weak self] in
            self?.contentView.alpha = 1
            self?.contentView.transform = CGAffineTransform.identity
        }
    }
    
    private func clearSortBySelection() {
        for (index, _) in sortByItems.enumerated() {
            sortByItems[index].isSelected = false
        }
    }
    
    private func clearSortOrderSelection() {
        for (index, _) in sortOrderItems.enumerated() {
            sortOrderItems[index].isSelected = false
        }
    }
    
    @IBAction func btApplyTapped(_ sender: Any) {
        guard let selectedSortBy = sortByItems.first(where: { $0.isSelected }) else { return }
        guard let selectedSortOrder = sortOrderItems.first(where: { $0.isSelected }) else { return }
        
        delegate?.didApplyFilter(sortBy: selectedSortBy, orderBy: selectedSortOrder)
        dismiss(animated: true)
    }
    
    @IBAction func btCancelTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

//MARK: - UICollectionViewDelegate
extension SearchFilterDialog: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cvSortBy {
            clearSortBySelection()
            sortByItems[indexPath.item].isSelected = true
        } else if collectionView == cvSortOrder {
            clearSortOrderSelection()
            sortOrderItems[indexPath.item].isSelected = true
        }
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDataSource
extension SearchFilterDialog: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SearchFilterCell
        if collectionView == cvSortBy && indexPath.item < sortByItems.count {
            cell.populate(sortByItems[indexPath.item])
        } else {
            cell.populate(sortOrderItems[indexPath.item])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cvSortBy {
            return sortByItems.count
        } else if collectionView == cvSortOrder {
            return sortOrderItems.count
        }
        return 0
    }
}

protocol SearchFilterDelegate {
    func didApplyFilter(sortBy: FilterItem, orderBy: FilterItem)
}
