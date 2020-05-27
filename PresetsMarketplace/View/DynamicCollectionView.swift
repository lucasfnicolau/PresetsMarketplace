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
    var collectionViewDataSource: DynamicCollectionViewDataSource?
    var collectionViewDelegate: DynamicCollectionViewDelegate?
    var dao: DynamicCollectionViewDAO
    
    init(collectionType: CollectionViewCellEnum, in viewController: UIViewController, using dao: DynamicCollectionViewDAO? = nil) {
        self.collectionEnum = collectionType
        self.dao = (dao == nil ? DynamicCollectionViewDAO(with: []) : dao!)

        super.init(frame: .zero, collectionViewLayout: layout)

        self.collectionViewDataSource = DynamicCollectionViewDataSource(collectionEnum: collectionType, for: self)
        self.collectionViewDelegate = DynamicCollectionViewDelegate(for: self, from: viewController)

        register(DynamicCollectionViewCell.self, forCellWithReuseIdentifier: Identifier.dynamicCollectionViewCell)
        register(DynamicColletionArtistViewCell.self, forCellWithReuseIdentifier: Identifier.dynamicCollectionArtistViewCell)
        configureCollectionView()

        self.backgroundColor = .clear
        self.showsVerticalScrollIndicator = false
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
