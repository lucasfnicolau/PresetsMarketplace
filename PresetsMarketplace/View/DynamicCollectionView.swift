//
//  DynamicCollectionView.swift
//  PresetsMarketplace
//
//  Created by gabriel on 20/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class DynamicCollectionView: UICollectionView {
    
    let layout = DynamicCollectionViewLayout()
    let collectionEnum: CollectionViewCellEnum
    let collectionViewDataSource: DynamicCollectionViewDataSource
    let collectionViewDelegate: DynamicCollectionViewDelegate
    let dao = DynamicCollectionViewDAO()
    
    init(collectionType: CollectionViewCellEnum) {
        self.collectionEnum = collectionType
        self.collectionViewDataSource = DynamicCollectionViewDataSource(collectionEnum: collectionType, for: dao)
        self.collectionViewDelegate = DynamicCollectionViewDelegate(for: dao)

        super.init(frame: .zero, collectionViewLayout: layout)

        register(DynamicCollectionViewCell.self, forCellWithReuseIdentifier: Identifier.dynamicCollectionViewCell)
        register(DynamicColletionArtistViewCell.self, forCellWithReuseIdentifier: Identifier.dynamicCollectionArtistViewCell)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCollectionView() {
        self.delegate = collectionViewDelegate
        self.dataSource = collectionViewDataSource
        self.reloadData()
    }
}
