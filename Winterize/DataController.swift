//
//  DataController.swift
//  Winterize
//
//  Created by Christopher Bonuel on 10/12/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import Moya
import RxSwift
import SwiftyJSON
import RealmSwift

class DataController {
    private let provider = RxMoyaProvider(endpointClosure: RachioService.endpointClosure)
    private let bag = DisposeBag()
    
    func fetchZones() {
        let user_id = provider.request(.person(id: nil))
            .mapString(atKeyPath: "id")
            
        user_id.subscribe(onNext: { id in
            self.provider.request(.person(id: id)).subscribe(onNext: { response in
                switch response.statusCode {
                case 200:
                    let json = JSON(data: response.data)
                    let devices = json["devices"].arrayValue
                    let realm = try! Realm()
                    _ = devices.flatMap { $0["zones"] }
                        .map { (_, zoneJSON) in
                            let zone = Zone(json: zoneJSON)
                            try! realm.write {
                                realm.add(zone)
                            }
                    }
                default:
                    // TODO: - Handle fetch failure
                    print(response.statusCode)
                }
            }).disposed(by: self.bag)
        }).disposed(by: bag)
    }
    
    func start(_ zone: Zone, duration: TimeInterval = RachioService.maximumZoneRunTime) {
        provider.request(.startZone(id: zone.id, duration: duration)).subscribe(onNext: { response in
            switch response.statusCode {
            case 204:
                break
            default:
                // TODO: - Handle start zone failure
                print(response.statusCode)
                print(JSON(data: response.data))
            }
        }).disposed(by: bag)
    }
}
