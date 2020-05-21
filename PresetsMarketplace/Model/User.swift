//
//  User.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 19/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import Foundation

class User: Equatable {
    var id: String
    var name: String
    var profileImageUrl: URL?

    init(id: String = "", name: String, profileImageLink: String) {
        self.id = id.count > 0 ? id : UUID().uuidString
        self.name = name
        self.profileImageUrl = URL(string: profileImageLink)
    }

    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
