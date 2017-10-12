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
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = false
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    override func layoutSubviews() {
        contentView.addSubview(label)
        contentView.addSubview(toggle)
        
        NSLayoutConstraint.activate([
            toggle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            toggle.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor),
            
            label.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            label.rightAnchor.constraint(equalTo: toggle.layoutMarginsGuide.leftAnchor),
            label.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    @discardableResult
    func configured(with zone: Zone) -> ZoneCell {
        label.text = zone.name
        return self
    }
}
