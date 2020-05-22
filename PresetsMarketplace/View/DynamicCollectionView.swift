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
    let presets: [Preset]
    var searchDelegate: SearchDelegate?
    weak var collectionViewDataSource: DynamicCollectionViewDataSource?
    weak var collectionViewDelegate: DynamicCollectionViewDelegate?
    
    init(collectionType: CollectionViewCellEnum, with presets: [Preset]) {
        self.collectionEnum = collectionType
        self.presets = presets

        super.init(frame: .zero, collectionViewLayout: layout)

        register(DynamicCollectionViewCell.self, forCellWithReuseIdentifier: Identifier.dynamicCollectionViewCell)
        register(DynamicColletionArtistViewCell.self, forCellWithReuseIdentifier: Identifier.dynamicCollectionArtistViewCell)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCollectionView() {
        let dataSource = DynamicCollectionViewDataSource(collectionEnum: collectionEnum, with: presets)
        let delegate = DynamicCollectionViewDelegate(with: presets)
        collectionViewDataSource = dataSource
        collectionViewDelegate = delegate
        searchDelegate = collectionViewDataSource

        self.delegate = collectionViewDelegate
        self.dataSource = collectionViewDataSource
        self.reloadData()
    }
}
