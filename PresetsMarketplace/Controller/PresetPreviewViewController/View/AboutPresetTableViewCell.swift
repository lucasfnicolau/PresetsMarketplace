//
//  AboutPresetTableViewCell.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 19/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class AboutPresetTableViewCell: UITableViewCell {
    @IBOutlet weak var aboutTitleTextView: UITextView!
    @IBOutlet weak var aboutDescriptionTextView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        aboutTitleTextView.text = "Sobre"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setLayout(forDescription description: String) {
        aboutDescriptionTextView.text = description
    }
}
