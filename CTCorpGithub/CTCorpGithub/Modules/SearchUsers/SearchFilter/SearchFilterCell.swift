//
//  SearchFilterCell.swift
//  CTCorpGithub
//
//  Created by Aslam Azis on 20/11/20.
//

import UIKit

class SearchFilterCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    
    private var item: FilterItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func populate(_ item: FilterItem) {
        self.item = item
        lbTitle.text = item.text
        setupSelectedViewState()
    }
    
    private func setupViews() {
        bgView.layer.cornerRadius = 8
        bgView.layer.borderColor = UIColor.systemBlue.cgColor
        bgView.layer.borderWidth = 1
        setupSelectedViewState()
    }
    
    private func setupSelectedViewState() {
        if item?.isSelected == true {
            bgView.backgroundColor = UIColor.systemBlue
            lbTitle.textColor = UIColor.white
        } else {
            bgView.backgroundColor = UIColor.systemBackground
            lbTitle.textColor = UIColor.systemBlue
        }
    }
    
}
