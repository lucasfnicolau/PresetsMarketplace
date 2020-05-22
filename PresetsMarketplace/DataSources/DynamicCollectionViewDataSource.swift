//
//  DynamicCollectionViewDataSource.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 22/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class DynamicCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    let collectionEnum: CollectionViewCellEnum
    let presets: [Preset]
    var filteredPresets: [Preset]

    init(collectionEnum: CollectionViewCellEnum, with presets: [Preset]) {
        self.collectionEnum = collectionEnum
        self.presets = presets
        self.filteredPresets = self.presets
        super.init()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch collectionEnum {
        case .user:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.dynamicCollectionViewCell, for: indexPath) as? DynamicCollectionViewCell else { return UICollectionViewCell() }
            cell.setup(image: #imageLiteral(resourceName: "praia"))
            return cell
        case .artist:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.dynamicCollectionArtistViewCell, for: indexPath) as? DynamicColletionArtistViewCell else { return UICollectionViewCell() }
            cell.setup(image: #imageLiteral(resourceName: "praia"), views: 500, sales: 500)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPresets.count
    }
}

extension DynamicCollectionViewDataSource: SearchDelegate {
    func search(usingQuery query: String, completion: @escaping ([Preset]) -> Void) {
        let formattedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        if formattedQuery.count == 0 {
            self.filteredPresets = self.presets
        } else {
            self.filteredPresets = self.presets.filter {
                $0.name.lowercased().contains(query) || $0.artist.name.lowercased().contains(query)
            }
        }

        completion(filteredPresets)
    }
}
