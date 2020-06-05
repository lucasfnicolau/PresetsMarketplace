//
//  ImagesAddedCollectionViewDataSource.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 04/06/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class ImagesAddedCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    let dao: ImagesAddedCollectionViewDAO
    let imagesHandlerDelegate: ImagesHandlerDelegate

    init(withDAO dao: ImagesAddedCollectionViewDAO,
         andImagesHandlerDelegate imagesHandlerDelegate: ImagesHandlerDelegate) {
        self.dao = dao
        self.imagesHandlerDelegate = imagesHandlerDelegate
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dao.images.count == 0 ? 1 : dao.images.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.row == 0 {
            if let addImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.addImageCollectionViewCell, for: indexPath) as? AddImageCollectionViewCell {

                addImageCell.imagesHandlerDelegate = imagesHandlerDelegate

                return addImageCell

            }
        } else {
            if let imageAddedCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.imageAddedCollectionViewCell, for: indexPath) as? ImageAddedCollectionViewCell {

                let row = indexPath.row - 1
                imageAddedCell.imagesHandlerDelegate = imagesHandlerDelegate

                if let image = dao.images[row] as? UIImage {
                    imageAddedCell.configure(forImage: image, onRow: row)
                }

                return imageAddedCell
            }
        }

        return UICollectionViewCell()
    }
}
