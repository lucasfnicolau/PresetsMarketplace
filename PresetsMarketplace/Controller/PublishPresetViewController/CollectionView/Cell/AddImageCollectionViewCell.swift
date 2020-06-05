//
//  AddImageCollectionViewCell.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 04/06/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class AddImageCollectionViewCell: UICollectionViewCell {
    weak var imagesHandlerDelegate: ImagesHandlerDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func addImageButtonTouched(_ sender: UIButton) {
        imagesHandlerDelegate?.showImagePickerController()
    }
}
