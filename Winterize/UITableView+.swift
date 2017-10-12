//
//  UITableView+.swift
//  Winterize
//
//  Created by Christopher Bonuel on 10/12/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import UIKit
import RxRealm

extension UITableView {
    func apply(_ changeSet: RealmChangeset) {
        beginUpdates()
        deleteRows(at: changeSet.deleted.map(IndexPath.fromRow), with: .automatic)
        insertRows(at: changeSet.inserted.map(IndexPath.fromRow), with: .automatic)
        reloadRows(at: changeSet.updated.map(IndexPath.fromRow), with: .automatic)
        endUpdates()
    }
}
