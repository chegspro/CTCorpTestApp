//
//  ExtImageView.swift
//  CTCorpGithub
//
//  Created by Aslam Azis on 20/11/20.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImage(from path: String, placeholder: UIImage? = UIImage(named: "github")) {
        guard let url = URL(string: path) else { return }
        self.kf.setImage(with: url, placeholder: placeholder)
    }

}
