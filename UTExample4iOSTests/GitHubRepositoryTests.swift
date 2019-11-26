//
//  GitHubRepositoryTests.swift
//  UnitTestExTests
//
//  Created by yuu on 2019/10/18.
//  Copyright © 2019 yuu. All rights reserved.
//

import XCTest
@testable import UTExample4iOS
import OHHTTPStubs

class GithubRepositoryTests: XCTestCase {
    func testFetchGtihubRepositoryFullName() {
        let c = GitHubAPIClient()
        let body: [[String: Any]] = [
            [
                "id": 1,
                "name": "swift",
                "stargazers_count": 10,
            ],
            [
                "id": 2,
                "name": "swift-evolution",
                "stargazers_count": 28,
            ]
        ]

        stub(condition: isHost("api.github.com") && isPath("/users/apple/repos")) { (req) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(jsonObject: body, statusCode: 200, headers: nil)
        }

        let exp = expectation(description: "wait for complete api")

        c.fetchRepositories(user: "apple") { (repo) in
            print("callback")
            XCTAssertEqual(repo?.count, 2)
            XCTAssertEqual(repo?[0], GitHubRepository(id: 1, star: 10, name: "swift"))
            XCTAssertEqual(repo?[1], GitHubRepository(id: 2, star: 28, name: "swift-evolution"))
            exp.fulfill()
        }

        wait(for: [exp], timeout: 3)
    }
}
