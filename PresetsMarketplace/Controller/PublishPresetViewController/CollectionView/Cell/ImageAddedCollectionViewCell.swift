//
//  ImageAddedCollectionViewCell.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 04/06/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class ImageAddedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    private var row = 0
    weak var imagesHandlerDelegate: ImagesHandlerDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
    }

    func configure(forImage image: UIImage, onRow row: Int) {
        self.imageView.image = image
        self.row = row
    }

    @IBAction func minusButtonTouched(_ sender: UIButton) {
        imagesHandlerDelegate?.removeImage(imageView.image ?? UIImage())
    }
}
