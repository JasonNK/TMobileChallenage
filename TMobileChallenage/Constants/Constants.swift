//
//  Constants.swift
//  TMobileChallenage
//
//  Created by Jason on 4/27/20.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation
enum StringConstants: String {
    case mainCellIdentifier = "cell"
    case detailCellIdentifier = "detailCell"
    case detailViewControllerId = "detailViewController"
    case userSearchEnd = "https://api.github.com/search/users?q="
    case repoSearchEnd = "https://api.github.com/users/"
    case requestGet = "GET"
    case requestHeadAcceptValue = "application/vnd.github.v3+json"
    case requestHeadAcceptKey = "Accept"
    case requestAuthToken = "7ed50bcd362f50a86913220e0b7d882f8d859d1e"
    case requestAuthBasic = "Basic"
    case requestHeadAuthKey = "Authorization"
    case rawDateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    case rawDateLocale = "en_US_POSIX"
    case targetDateFormat = "d MMM y"
    case followers = " Followers"
    case following = "Following "
    case navigationTitle = "Github Searcher"
    case userName = "UserName: "
    case email = "Email: "
}

enum IntConstants: Int {
    case countMainPerPage = 30
}
