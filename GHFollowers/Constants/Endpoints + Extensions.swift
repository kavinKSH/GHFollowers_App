//
//  Endpoints + Extensions.swift
//  GHFollowers
//
//  Created by Kavin on 09/04/24.
//

import Foundation

struct Endpoints {
    let path:String
    let queryParameters:[URLQueryItem]
}

extension Endpoints {
    static func getFollowers(userName: String, page: Int)->Endpoints {
        return Endpoints(path: "/users/\(userName)/followers", queryParameters: [URLQueryItem(name: "per_page", value: "100"),
            URLQueryItem(name: "page", value: "\(page)")])
    }
    static func getUsers(userName: String,page: Int)->Endpoints {
        return Endpoints(path: "/users/\(userName)", queryParameters: [URLQueryItem(name: "per_page", value: "100"),
        URLQueryItem(name: "page", value: "\(page)")])
    }
}

extension Endpoints {
    var url: URL? {
        var components = URLComponents()
        components.scheme       = "https"
        components.host         = "api.github.com"
        components.path         = path
        components.queryItems   = queryParameters
        return components.url
    }
}
