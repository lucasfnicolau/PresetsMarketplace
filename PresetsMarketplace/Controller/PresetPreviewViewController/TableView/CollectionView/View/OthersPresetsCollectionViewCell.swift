//
//  OthersPresetsCollectionViewCell.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 21/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class OthersPresetsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var presetImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(for preset: Preset) {
        presetImageView.load(url: preset.imagesURLs[0])
        presetImageView.layer.cornerRadius = 4
    }
}
