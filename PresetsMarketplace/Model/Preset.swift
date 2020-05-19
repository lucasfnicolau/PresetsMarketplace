//
//  Preset.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 19/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import Foundation

class Preset {
    var name: String
    var artist: Artist
    private(set) var price: Double = 0
    private(set) var viewsCount: Int = 0
    private(set) var soldCound: Int = 0

    init(name: String, artist: Artist, price: Double = 0) {
        self.name = name
        self.artist = artist
        setPrice(price)
    }

    func setPrice(_ price: Double) {
        guard price >= 0 else { return }
        self.price = price
    }

    func incrementSoldCount() {
        self.viewsCount += 1
    }

    func incrementViewsCount() {
        self.viewsCount += 1
    }
}
