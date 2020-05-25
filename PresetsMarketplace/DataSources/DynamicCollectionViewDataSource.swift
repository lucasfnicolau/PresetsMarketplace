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
    let dao: DynamicCollectionViewDAO

    init(collectionEnum: CollectionViewCellEnum, for dao: DynamicCollectionViewDAO) {
        self.collectionEnum = collectionEnum
        self.dao = dao
        super.init()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let item = indexPath.item
        let preset = dao.filteredPresets[item]

        switch collectionEnum {
        case .user:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.dynamicCollectionViewCell, for: indexPath) as? DynamicCollectionViewCell else { return UICollectionViewCell() }
            cell.setup(for: preset)
            return cell
        case .artist:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.dynamicCollectionArtistViewCell, for: indexPath) as? DynamicColletionArtistViewCell else { return UICollectionViewCell() }
            cell.setup(for: preset)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dao.filteredPresets.count
    }
}
