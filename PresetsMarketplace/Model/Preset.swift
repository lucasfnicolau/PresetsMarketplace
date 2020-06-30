//
//  Preset.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 19/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import Foundation

class Preset: Equatable, Hashable {

    let id: String
    var name: String
    var artist: Artist
    var description: String = ""
    let dngPath: String
    private(set) var imagesURLs: [URL?] = []
    private(set) var imagesData: [Data] = []
    private(set) var price: Double = 0
    private(set) var viewsCount: Int = 0
    private(set) var soldCount: Int = 0

    convenience init() {
        self.init(name: "", artist: Artist(), dngPath: "")
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    init(id: String = "", name: String, artist: Artist, description: String = "", dngPath: String, price: Double = 0, imagesLinks: [String] = []) {
        self.id = id.count > 0 ? id : UUID().uuidString
        self.name = name
        self.artist = artist
        self.description = description
        self.dngPath = dngPath
        addImagesURLs(from: imagesLinks)
        setPrice(to: price)
    }

    func loadImagesData(withCompletion completion: @escaping () -> Void) {
        if imagesData.isEmpty {
            DispatchQueue.global().async {
                for url in self.imagesURLs {
                    guard let url = url else { continue }
                    do {
                        let data = try Data(contentsOf: url)
                        self.imagesData.append(data)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                completion()
            }
        } else { completion() }
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

    static func == (lhs: Preset, rhs: Preset) -> Bool {
        return lhs.name == rhs.name && lhs.artist == rhs.artist
    }
}
