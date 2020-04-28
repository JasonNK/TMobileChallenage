//
//  UserViewModel.swift
//  TMobileChallenage
//
//  Created by Jason on 4/17/20.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

class UserViewModel {
    
    var users = [User]()
    let webUtil = WebUtil()
    
    /*
     search for certain user's information and get their avartar image and repository count
     */
    func searchFor(username: String, curPage: Int = 1, completion: @escaping () -> ()) {
        let url = StringConstants.userSearchEnd.rawValue + username
        let dg = DispatchGroup()
        webUtil.getCodedData(urlString: url + "&page=\(curPage)") {[weak self] (userStatistic: UserWrapper?, error) in
            guard let self = self else { return }
            let result = userStatistic?.items ?? []
            if curPage == 1 {
                self.users = result
            } else {
                self.users.append(contentsOf: result)
            }
            let n = self.users.count
            for i in 0..<n {
                dg.enter()
                self.webUtil.getData(urlString: self.users[i].avatar_url) { [weak self] (data, error) in
                    guard let self = self else { return }
                    self.users[i].image = data
                    dg.leave()
                }
                dg.enter()
                self.webUtil.getCodedData(urlString: self.users[i].url) { [weak self] (detail: Detail?, error) in
                    guard let self = self else { return }
                    self.users[i].detail = detail
                    dg.leave()
                }
            }
            dg.notify(queue: .main) {
                completion()
            }
        }
    }
    
    /*
     get detail information of one user
     */
    func getDetail(indexOfUser: Int, completion: @escaping () -> ()) {
        webUtil.getCodedData(urlString: users[indexOfUser].url) { (detail: Detail?, error) in
            self.users[indexOfUser].detail = detail
            completion()
        }
    }
    
    
}
