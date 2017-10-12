//
//  DataController.swift
//  Winterize
//
//  Created by Christopher Bonuel on 10/12/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import Moya
import RxSwift

class DataController {
    private let provider = RxMoyaProvider(endpointClosure: RachioService.endpointClosure)
}
