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
    case requestAuthToken = "2742df61e1e820a0d81a:bdd972e2b30e8908acb6aea896a06b102120884c"
    case requestAuthBasic = "Basic"
    case requestHeadAuthKey = "Authorization"
    case rawDateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    case rawDateLocale = "en_US_POSIX"
    case targetDateFormat = "d MMM y"
    case followers = " Followers"
    case following = "Following "
    case navigationTitle = "Github Searcher"
}

enum IntConstants: Int {
    case countMainPerPage = 30
}
