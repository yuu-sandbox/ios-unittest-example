//
//  GitHubAPIClient.swift
//  UTExample4iOS
//
//  Created by yuu on 2019/11/26.
//  Copyright © 2019 yuu. All rights reserved.
//

import Foundation

protocol GitHubAPIClientProtocol {
    func fetchRepositories(user: String,
                           handler: @escaping ([GitHubRepository]?) -> Void)
}

class GitHubAPIClient: GitHubAPIClientProtocol {
    func fetchRepositories(user: String,
                           handler: @escaping ([GitHubRepository]?) -> Void) {
        let url = URL(string: "https://api.github.com/users/\(user)/repos")!
        let req = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: req) { (data, _, error) in
            guard let data = data, error == nil else {
                handler(nil)
                return
            }
            let repos = try! JSONDecoder().decode([GitHubRepository].self, from: data)
            handler(repos)
        }
        task.resume()
    }
}

class MockGitHubAPIClient: GitHubAPIClientProtocol {
    var actual: [GitHubRepository]
    var user: String?

    init(actual: [GitHubRepository]) {
        self.actual = actual
    }

    func fetchRepositories(user: String,
                           handler: @escaping ([GitHubRepository]?) -> Void) {
        self.user = user
        handler(self.actual)
    }
}
