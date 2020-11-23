//
//  EmptyStateView.swift
//  CTCorpGithub
//
//  Created by Aslam Azis on 20/11/20.
//

import UIKit

class EmptyStateView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubtitle: UILabel!
    
    init() {
        super.init(frame: .zero)
        fromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fromNib()
    }
    
    func populate(image: UIImage, title: String, subtitle: String) {
        imageView.image = image
        self.lbTitle.text = title
        self.lbSubtitle.text = subtitle
    }
    
}

