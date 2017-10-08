//
//  RachioService.swift
//  Winterize
//
//  Created by Christopher Bonuel on 10/8/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import Foundation
import Moya

enum RachioService {
    case person
}

extension RachioService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.rach.io")!
    }
    
    var path: String {
        switch self {
        case .person:
            return "/1/public/person/info"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .person:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .person:
            return nil
        }
    }
}
