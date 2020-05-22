//
//  DynamicCollectionViewDelegate.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 22/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class DynamicCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    private var presets: [Preset]

    init(with presets: [Preset]) {
        self.presets = presets
        super.init()
    }

    func updatePresets(to presets: [Preset]) {
        self.presets = presets
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO
    }
}
