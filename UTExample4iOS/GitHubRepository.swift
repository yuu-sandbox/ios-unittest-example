//
//  GitHubRepository.swift
//  UnitTestEx
//
//  Created by yuu on 2019/10/18.
//  Copyright © 2019 yuu. All rights reserved.
//

import Foundation

struct GitHubRepository: Codable, Equatable {
    let id: Int32
    let star: Int32
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case star = "stargazers_count"
        case name
    }
}
