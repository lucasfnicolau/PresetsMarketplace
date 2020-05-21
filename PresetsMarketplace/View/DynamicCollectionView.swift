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
    let img = #imageLiteral(resourceName: "praia")
    let cellSizes: [CGFloat] = [200, 250, 300]
    
    init(collectionType: CollectionViewCellEnum) {
        self.collectionEnum = collectionType
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.dataSource = self
        layout.delegate = self
        
        register(DynamicCollectionViewCell.self, forCellWithReuseIdentifier: "DynamicCollectionViewCell")
        register(DynamicColletionArtistViewCell.self, forCellWithReuseIdentifier: "DynamicCollectionArtistViewCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DynamicCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionEnum {
        case .user:
            guard let cell = dequeueReusableCell(withReuseIdentifier: "DynamicCollectionViewCell", for: indexPath) as? DynamicCollectionViewCell else { return UICollectionViewCell() }
            cell.setup(image: img)            
            return cell
        case .artist:
            guard let cell = dequeueReusableCell(withReuseIdentifier: "DynamicCollectionArtistViewCell", for: indexPath) as? DynamicColletionArtistViewCell else { return UICollectionViewCell() }
            cell.setup(image: img, views: 50, sales: 50)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
}

extension DynamicCollectionView: DynamicCollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        guard let size = cellSizes.randomElement() else { return 150 }
        return size
    }
}
