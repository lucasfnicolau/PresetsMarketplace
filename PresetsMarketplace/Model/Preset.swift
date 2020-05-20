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
    var description: String = ""
    private(set) var imagesURLs: [URL?] = []
    private(set) var price: Double = 0
    private(set) var viewsCount: Int = 0
    private(set) var soldCount: Int = 0

    init(name: String, artist: Artist, description: String = "", price: Double = 0, imagesLinks: [String] = []) {
        self.name = name
        self.artist = artist
        self.description = description
        addImagesURLs(from: imagesLinks)
        setPrice(to: price)
    }

    func addImagesURLs(from imagesLinks: [String]) {
        self.imagesURLs.append(contentsOf: URLManager.getURLArray(from: imagesLinks))
    }

    // MARK: - REDO
    func removeImagesURLs(matching array: [URL?]) {
        array.forEach { url in
            imagesURLs.removeAll { $0 == url }
        }
    }

    func setPrice(to price: Double) {
        guard price >= 0 else { return }
        self.price = price
    }

    func incrementSoldCount() {
        self.soldCount += 1
    }

    func incrementViewsCount() {
        self.viewsCount += 1
    }
}
