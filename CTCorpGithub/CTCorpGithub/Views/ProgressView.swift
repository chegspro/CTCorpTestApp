//
//  ProgressView.swift
//  CTCorpGithub
//
//  Created by Aslam Azis on 20/11/20.
//

import UIKit

class ProgressView {
    
    var backView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        var indicator = UIActivityIndicatorView()
        var isShown = false
        
        public static let shared = ProgressView()
        
        private init(){}
        
        public func show(show: Bool, view: UIView) {
            if show && !isShown {
                DispatchQueue.main.async {
                    var view = view
                    if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
                        view = window
                    }
                    self.backView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
                    self.backView.center = view.center
                    self.backView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
                    self.backView.clipsToBounds = true
                    self.backView.layer.cornerRadius = 10
                    
                    self.indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                    self.indicator.style = UIActivityIndicatorView.Style.large
                    self.indicator.center = CGPoint(x: self.backView.bounds.width / 2, y: self.backView.bounds.height / 2)
                    
                    self.backView.contentView.addSubview(self.indicator)
                    view.addSubview(self.backView)
                    self.isShown = true
                    self.indicator.startAnimating()
                }
            } else if !show && isShown {
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                    self.backView.removeFromSuperview()
                    self.isShown = false
                }
            }
        }
    
}
