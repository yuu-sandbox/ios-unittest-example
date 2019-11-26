//
//  GitHubRepositoryManager.swift
//  UTExample4iOS
//
//  Created by yuu on 2019/11/26.
//  Copyright © 2019 yuu. All rights reserved.
//

import Foundation

class GitHubRepositoryManager {
    private let client: GitHubAPIClientProtocol
    private var repos: [GitHubRepository]?

    var majorRepositories: [GitHubRepository] {
        guard let repos = self.repos else { return [] }
        return repos.filter { $0.star >= 10 }
    }

    init(client: GitHubAPIClientProtocol) {
        self.client = client
    }

    func load(user: String, completion: @escaping () -> Void) {
        self.client.fetchRepositories(user: user) { (repos) in
            DispatchQueue.main.async {
                self.repos = repos
                completion()
            }
        }
    }
}
