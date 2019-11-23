//
//  PreviewConstant.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-13.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import Foundation

final class PreviewConstants {
    static var branche: Branche {
        let req = """
        {
          "name": "master",
          "commit": {
            "sha": "c5b97d5ae6c19d5c5df71a34c7fbeeda2479ccbc",
            "url": "https://api.github.com/repos/octocat/Hello-World/commits/c5b97d5ae6c19d5c5df71a34c7fbeeda2479ccbc"
          },
          "protected": true,
          "protection": {
            "enabled": true,
            "required_status_checks": {
              "enforcement_level": "non_admins",
              "contexts": [
                "ci-test",
                "linter"
              ]
            }
          },
          "protection_url": "https://api.github.com/repos/octocat/hello-world/branches/master/protection"
        }
        """.data(using: .utf8)!
        return try! JSONDecoder().decode(Branche.self, from: req)
    }
    
    static var readme: Content {
        let req = """
            {
              "type": "file",
              "encoding": "base64",
              "size": 5362,
              "name": "README.md",
              "path": "README.md",
              "content": "encoded content ...",
              "sha": "3d21ec53a331a6f037a91c368710b99387d012c1",
              "url": "https://api.github.com/repos/octokit/octokit.rb/contents/README.md",
              "git_url": "https://api.github.com/repos/octokit/octokit.rb/git/blobs/3d21ec53a331a6f037a91c368710b99387d012c1",
              "html_url": "https://github.com/octokit/octokit.rb/blob/master/README.md",
              "download_url": "https://raw.githubusercontent.com/octokit/octokit.rb/master/README.md",
              "_links": {
                "git": "https://api.github.com/repos/octokit/octokit.rb/git/blobs/3d21ec53a331a6f037a91c368710b99387d012c1",
                "self": "https://api.github.com/repos/octokit/octokit.rb/contents/README.md",
                "html": "https://github.com/octokit/octokit.rb/blob/master/README.md"
              }
            }
        """.data(using: .utf8)!
        return try! JSONDecoder().decode(Content.self, from: req)
    }
    
    static var user: User = User(id: 1, login: "Donrakes", email: "email@mail.com", name: "Name", bio: "Bio", avatarUrl: nil)
}
