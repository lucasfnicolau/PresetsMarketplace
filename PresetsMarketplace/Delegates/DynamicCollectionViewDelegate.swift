//
//  DynamicCollectionViewDelegate.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 22/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class DynamicCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    private let dao: DynamicCollectionViewDAO

    init(for dao: DynamicCollectionViewDAO) {
        self.dao = dao
        super.init()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item: \(indexPath.item) | Row: \(indexPath.row) | Name: \(dao.filteredPresets[indexPath.item].name)")
    }
}
