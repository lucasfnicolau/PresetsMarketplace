//
//  ArtistPresetTableViewCell.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 19/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class ArtistPresetTableViewCell: UITableViewCell {
    @IBOutlet weak var artistTitleTextView: UITextView!
    @IBOutlet weak var artistAboutDescriptionLabel: UILabel!
    @IBOutlet weak var seePageLabel: UILabel!
    @IBOutlet weak var profileImageView: CircleImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        artistTitleTextView.text = "Artista"
        seePageLabel.text = "Ver página"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setLayout(for artist: Artist) {
        artistAboutDescriptionLabel.text = artist.about
        profileImageView.load(url: artist.profileImageUrl)
    }
}
