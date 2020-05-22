//
//  DynamicCollectionViewDelegate.swift
//  PresetsMarketplace
//
//  Created by Andrew Kharchyshyn and modified by Pedro Henrique Guedes Silveira on 19/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

protocol DynamicCollectionViewDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}
