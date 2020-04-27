//
//  DetailViewModel.swift
//  TMobileChallenage
//
//  Created by Jason on 4/19/20.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

class DetailViewModel {
    var repos = [Repo]()
    let webUtil = WebUtil()
    var searchRepos = [Repo]()
    func getRepo(username: String, completion: @escaping () -> ()) {
        
        webUtil.getCodedData(urlString: StringConstants.repoSearchEnd.rawValue + "\(username)/repos") { (userRepos: [Repo]?, error) in
            
            self.repos = userRepos ?? []
            completion()
        }
    }
}
