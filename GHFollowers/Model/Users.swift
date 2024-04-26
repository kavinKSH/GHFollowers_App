//
//  Users.swift
//  GHFollowers
//
//  Created by Kavin on 26/03/24.
//

import Foundation

struct Users: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int?
    let publicGists: Int?
    let followers: Int?
    let following: Int?
    let htmlUrl: String
    let createdAt: Date
}
