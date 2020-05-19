//
//  OthersPresetsTableViewCell.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 19/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class OthersPresetsTableViewCell: UITableViewCell {
    @IBOutlet weak var otherPresetsTitleTextView: UITextView!
    @IBOutlet weak var otherPresetsCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        otherPresetsTitleTextView.text = "Outros presets"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
