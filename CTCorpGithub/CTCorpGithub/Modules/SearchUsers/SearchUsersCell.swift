//
//  SearchUsersCell.swift
//  CTCorpGithub
//
//  Created by Aslam Azis on 20/11/20.
//

import UIKit
import CTCorpAPI
import Kingfisher

class SearchUsersCell: UITableViewCell {

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var imgUsername: UILabel!
    @IBOutlet weak var imgLink: UILabel!
    
    var delegate: SearchUsersCellDelegate?
    var user: User?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
    }
    
    func setupViews() {
        imgAvatar.layer.cornerRadius = 32
        imgAvatar.layer.shadowColor = UIColor.black.withAlphaComponent(0.15).cgColor
        imgAvatar.layer.shadowRadius = 8
        imgAvatar.layer.shadowOffset = CGSize(width: 0, height: 2)
        imgLink.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.linkTapped)))
    }
    
    func populate(user: User) {
        self.user = user
        imgAvatar.loadImage(from: user.avatarURL)
        imgUsername.text = user.login
        imgLink.text = user.htmlURL
    }
    
    @objc func linkTapped() {
        guard let user = user else { return }
        delegate?.didTapLink(path: user.htmlURL)
    }
    
}

protocol SearchUsersCellDelegate {
    func didTapLink(path: String)
}
