//
//  OthersPresetsCollectionViewDataSource.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 21/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class OthersPresetsCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var presets: [Preset]

    init(with presets: [Preset]) {
        self.presets = presets
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presets.count <= 3 ? presets.count : 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let othersPresetsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.othersPresetsCollectionViewCell, for: indexPath) as? OthersPresetsCollectionViewCell {

            othersPresetsCollectionViewCell.setup(for: presets[indexPath.row])
            return othersPresetsCollectionViewCell
        }

        return UICollectionViewCell()
    }

}
