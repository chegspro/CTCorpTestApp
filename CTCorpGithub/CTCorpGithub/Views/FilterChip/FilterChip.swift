//
//  FilterChip.swift
//  CTCorpGithub
//
//  Created by Aslam Azis on 20/11/20.
//

import UIKit

class FilterChip: UIButton {
    
    private var _isSelected = false
    
    override var isSelected: Bool {
        get {
            return _isSelected
        }
        set {
            _isSelected = newValue
            setSelectedStateView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        heightAnchor.constraint(equalToConstant: 32.0).isActive = true
        setTitleColor(UIColor.white, for: .selected)
        setTitleColor(UIColor.black, for: .normal)
        layer.borderColor = UIColor.blue.cgColor
        setSelectedStateView()
    }
    
    private func setSelectedStateView() {
        if isSelected {
            backgroundColor = UIColor.blue
            layer.borderWidth = 0
        } else {
            backgroundColor = UIColor.clear
            layer.borderWidth = 1
        }
    }
    
}
