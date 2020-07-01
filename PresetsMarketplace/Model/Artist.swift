//
//  Artist.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 19/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import Foundation

class Artist: User {
    var presets: [Preset] = []
    var about: String

    convenience init() {
        self.init(name: "", about: "", profileImageLink: "")
    }

    init(id: String = UUID().uuidString, name: String, about: String, profileImageLink: String) {
        self.about = about
        super.init(id: id, name: name, profileImageLink: profileImageLink)
    }
}
