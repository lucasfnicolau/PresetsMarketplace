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
        if artist.profileImageUrl != nil {
            profileImageView.load(url: artist.profileImageUrl)
        } else {
            self.profileImageView.image = UIImage(named: "profile_thumbnail_bg")
            setupLabel()
            let size: CGFloat = PROFILE_IMAGE_SIZE
            self.profileImageView.layer.cornerRadius = size / 2
            NSLayoutConstraint.activate([
                self.profileImageView.widthAnchor.constraint(equalToConstant: size),
                self.profileImageView.heightAnchor.constraint(equalToConstant: size)
            ])
        }
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = PROFILE_IMAGE_SIZE / 2
    }

    func setupLabel() {
        let profileImageLabel = UILabel()
        let letter = DAO.shared.user?.name.prefix(1) ?? Mock.shared.user.name.prefix(1)
        profileImageLabel.text = String(letter.uppercased())
        profileImageLabel.font = profileImageLabel.font.withSize(35)
        profileImageLabel.textAlignment = .center
        profileImageLabel.textColor = .black

        profileImageView.addSubview(profileImageLabel)
        profileImageLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profileImageLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            profileImageLabel.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor),
            profileImageLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            profileImageLabel.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor)
        ])
    }
}
