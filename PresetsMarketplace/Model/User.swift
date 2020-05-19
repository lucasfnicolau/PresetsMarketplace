//
//  User.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 19/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import Foundation

class User {
    var name: String
    var about: String
    var profileImageUrl: URL?

    init(name: String, about: String, profileImageLink: String) {
        self.name = name
        self.about = about
        self.profileImageUrl = URL(string: profileImageLink)
    }
}
