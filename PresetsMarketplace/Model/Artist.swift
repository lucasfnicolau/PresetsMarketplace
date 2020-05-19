//
//  Artist.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 19/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import Foundation

class Artist: User {
    var about: String

    init(name: String, about: String, profileImageLink: String) {
        self.about = about
        super.init(name: name, profileImageLink: profileImageLink)
    }
}
