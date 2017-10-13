//
//  Zone.swift
//  Winterize
//
//  Created by Christopher Bonuel on 10/10/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class Zone: Object {
    dynamic var id = ""
    dynamic var number = 0
    dynamic var name = ""
    dynamic var isRunning = false

    convenience init(id: String, number: Int, name: String) {
        self.init()
        self.id = id
        self.number = number
        self.name = name
    }
    
    convenience init(json: JSON) {
        let id = json["id"].stringValue
        let number = json["zoneNumber"].intValue
        let name = json["name"].stringValue
        self.init(id: id, number: number, name: name)
    }
}
