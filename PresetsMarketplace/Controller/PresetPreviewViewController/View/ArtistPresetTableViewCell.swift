//
//  ArtistPresetTableViewCell.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 19/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class ArtistPresetTableViewCell: UITableViewCell {
    let PROFILE_IMAGE_SIZE: CGFloat = 80

    @IBOutlet weak var artistTitleTextView: UITextView!
    @IBOutlet weak var artistAboutDescriptionLabel: UILabel!
    @IBOutlet weak var seePageLabel: UILabel!
    @IBOutlet weak var profileImageView: CircleImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        artistTitleTextView.text = "Artista"
        seePageLabel.text = "Ver página"

        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: PROFILE_IMAGE_SIZE),
            profileImageView.heightAnchor.constraint(equalToConstant: PROFILE_IMAGE_SIZE)
        ])
        profileImageView.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setLayout(for artist: Artist) {
        artistAboutDescriptionLabel.text = artist.about
        profileImageView.load(url: artist.profileImageUrl)
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = PROFILE_IMAGE_SIZE / 2
    }
}
