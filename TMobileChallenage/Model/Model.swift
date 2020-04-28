//
//  Model.swift
//  TMobileChallenage
//
//  Created by Jason on 4/17/20.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct User: Codable {
    let login: String
    let avatar_url: String
    let repos_url: String
    let url: String
    var detail: Detail?
    var image: Data?
}

struct UserWrapper: Codable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [User]
}

struct Repo: Codable {
    let name: String
    let html_url: String?
    let forks_count: Int
    let stargazers_count: Int
}

struct Detail: Codable {
    let login: String
    let avatar_url: String
    let repos_url: String
    let url: String
    let location: String?
    let email: String?
    let bio: String?
    let public_repos: Int
    let followers: Int
    let following: Int
    let created_at: String
}
