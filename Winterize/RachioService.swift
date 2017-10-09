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
    case person(id: String?)
    case startZone(id: String, duration: TimeInterval)
    
    fileprivate static let api_token = "599c4261-103d-4e9a-b5c4-06558c7fcbe9"
    static let endpointClosure = { (target: RachioService) -> Endpoint<RachioService> in
        return Endpoint<RachioService>(url: "\(target.baseURL)\(target.path)",
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            parameters: target.parameters,
            parameterEncoding: target.parameterEncoding,
            httpHeaderFields: target.headers)
    }
}

extension RachioService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.rach.io")!
    }
    
    var path: String {
        switch self {
        case .person(let id?):
            return "/1/public/person/\(id)"
        case .person:
            return "/1/public/person/info"
        case .startZone:
            return "/1/public/zone/start"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .person:
            return .get
        case .startZone:
            return .put
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .person:
            return nil
        case .startZone(let id, let duration):
            return ["id": id, "duration": duration]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data {
        switch self {
        // TODO: case .person(let id?): return long json string
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
