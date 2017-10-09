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
    
    fileprivate static let api_token = "599c4261-103d-4e9a-b5c4-06558c7fcbe9"
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
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data {
        switch self {
        case .person:
            return "{\"id\" : \"c8d10892-fd69-48b3-8743-f111e4392d8a\"}".utf8Encoded
        }
    }
    
    var task: Task {
        switch self {
        case .person:
            return .request
        }
    }
}

extension RachioService {
    var headers: [String: String]? {
        return ["Content-Type": "application/json", "Authorization": "Bearer \(RachioService.api_token)"]
    }
}

private extension String {
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}
