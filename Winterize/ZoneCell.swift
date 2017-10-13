//
//  ZoneCell.swift
//  Winterize
//
//  Created by Christopher Bonuel on 10/11/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import UIKit
import RxSwift
import ValueStepper

class ZoneCell: UITableViewCell {
    static let reuseIdentifier = "ZoneCell"
    let bag = DisposeBag()
    
    // MARK: - UI
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stepper: ValueStepper = {
        let stepper = ValueStepper()
        stepper.maximumValue = RachioService.maximumZoneRunTime / 60
        stepper.backgroundColor = UIColor.clear
        stepper.tintColor = UIColor.rachioBlue
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
    lazy var toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = false
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    override func layoutSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(stepper)
        contentView.addSubview(toggle)
        
        NSLayoutConstraint.activate([
            toggle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            toggle.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor),
            
            // TODO: un-hardcode this constant
            stepper.rightAnchor.constraint(equalTo: toggle.layoutMarginsGuide.leftAnchor, constant: -20),
            stepper.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stepper.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            nameLabel.rightAnchor.constraint(equalTo: stepper.layoutMarginsGuide.leftAnchor),
            nameLabel.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
        ])
    }
    
    @discardableResult
    func configured(with zone: Zone) -> ZoneCell {
        nameLabel.text = zone.name
        toggle.isOn = zone.isRunning
        return self
    }
}
