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
    let img = #imageLiteral(resourceName: "profile_selected")
    
    init(collectionType: CollectionViewCellEnum) {
        self.collectionEnum = collectionType
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.dataSource = self
        layout.delegate = self
        
        register(DynamicCollectionViewCell.self, forCellWithReuseIdentifier: "DynamicCollectionViewCell")
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
        default:
            return UICollectionViewCell()
//        case .artist:
//            let cell = DynamicColletionArtistViewCell(content: UIImageView(image: #imageLiteral(resourceName: "profile_selected")), views: 10, sales: 5)
//            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
}

extension DynamicCollectionView: DynamicCollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return img.size.height
    }
}
