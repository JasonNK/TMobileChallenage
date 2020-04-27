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
    func searchFor(username: String, curPage: Int = 1, completion: @escaping () -> ()) {
        
        let url = StringConstants.userSearchEnd.rawValue + username
        let dg = DispatchGroup()
        webUtil.getCodedData(urlString: url + "&page=\(curPage)") { (userStatistic: UserWrapper?, error) in
            let result = userStatistic?.items ?? []
            if curPage == 1 {
                self.users = result
            } else {
                self.users.append(contentsOf: result)
            }
            let n = self.users.count
            for i in 0..<n {

                dg.enter()
                self.webUtil.getData(urlString: self.users[i].avatar_url) { (data, error) in
                    self.users[i].image = data
                    dg.leave()
                }
                dg.enter()
                self.webUtil.getCodedData(urlString: self.users[i].url) { (detail: Detail?, error) in
                    self.users[i].detail = detail
                    dg.leave()
                }
                
                
            }
            dg.notify(queue: .main) {
                completion()
            }
            
        }
    }
    
    func getDetail(indexOfUser: Int, completion: @escaping () -> ()) {
        webUtil.getCodedData(urlString: users[indexOfUser].url) { (detail: Detail?, error) in
            self.users[indexOfUser].detail = detail
            completion()
        }

    }
    
    
}
