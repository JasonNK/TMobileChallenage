//
//  TMobileChallenageTests.swift
//  TMobileChallenageTests
//
//  Created by Jason on 4/17/20.
//  Copyright © 2020 Jason. All rights reserved.
//

import XCTest
@testable import TMobileChallenage

class MockURLSession: URLSessionProtocol {
    func getData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let data = """
            [
            {
              "login": "mojombo",
              "id": 1,
              "node_id": "MDQ6VXNlcjE=",
              "avatar_url": "https://avatars0.githubusercontent.com/u/1?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/mojombo",
              "html_url": "https://github.com/mojombo",
              "followers_url": "https://api.github.com/users/mojombo/followers",
              "following_url": "https://api.github.com/users/mojombo/following{/other_user}",
              "gists_url": "https://api.github.com/users/mojombo/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/mojombo/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/mojombo/subscriptions",
              "organizations_url": "https://api.github.com/users/mojombo/orgs",
              "repos_url": "https://api.github.com/users/mojombo/repos",
              "events_url": "https://api.github.com/users/mojombo/events{/privacy}",
              "received_events_url": "https://api.github.com/users/mojombo/received_events",
              "type": "User",
              "site_admin": false
            },
            {
              "login": "defunkt",
              "id": 2,
              "node_id": "MDQ6VXNlcjI=",
              "avatar_url": "https://avatars0.githubusercontent.com/u/2?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/defunkt",
              "html_url": "https://github.com/defunkt",
              "followers_url": "https://api.github.com/users/defunkt/followers",
              "following_url": "https://api.github.com/users/defunkt/following{/other_user}",
              "gists_url": "https://api.github.com/users/defunkt/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/defunkt/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/defunkt/subscriptions",
              "organizations_url": "https://api.github.com/users/defunkt/orgs",
              "repos_url": "https://api.github.com/users/defunkt/repos",
              "events_url": "https://api.github.com/users/defunkt/events{/privacy}",
              "received_events_url": "https://api.github.com/users/defunkt/received_events",
              "type": "User",
              "site_admin": false
            }
            ]
        """.data(using: .utf8)
        completion(data, HTTPURLResponse.init(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
    }
    
    
}


class TMobileChallenageTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUsers() throws {
        WebUtil.init(urlSession: MockURLSession()).getCodedData(urlString: "test.users.com") { (users: [User]?, error) in
            XCTAssertNotNil(users)
            XCTAssertEqual(users?.count, 2)
            XCTAssertNil(error)
        }
    }
}
