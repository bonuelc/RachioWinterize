//
//  ZoneCell.swift
//  Winterize
//
//  Created by Christopher Bonuel on 10/11/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import UIKit

class ZoneCell: UITableViewCell {
    static let reuseIdentifier = "ZoneCell"
    
    // MARK: - UI
    
    lazy var toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    override func layoutSubviews() {
        contentView.addSubview(toggle)
        
        NSLayoutConstraint.activate([
            toggle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            toggle.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor)
        ])
    }
}
