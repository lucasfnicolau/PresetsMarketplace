//
//  ProfileViewController.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 18/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var artistInfoStackView: UIStackView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artistAboutLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var presetsCollectionView: DynamicCollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Perfil"
        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presetsCollectionView?.dao = DynamicCollectionViewDAO(with: Mock.shared.user.acquiredPresets)
        presetsCollectionView?.reloadData()
    }

    func setupViews() {
        artistNameLabel.text = Mock.shared.user.name
        if let artist = Mock.shared.user as? Artist {
            artistAboutLabel.text = artist.about
        }

        profileImageView.load(url: Mock.shared.user.profileImageUrl) { _ in
            let size: CGFloat = 125
            self.profileImageView.layer.cornerRadius = size / 2
            NSLayoutConstraint.activate([
                self.profileImageView.widthAnchor.constraint(equalToConstant: size),
                self.profileImageView.heightAnchor.constraint(equalToConstant: size)
            ])
        }

        let dao = DynamicCollectionViewDAO(with: Mock.shared.user.acquiredPresets)
        presetsCollectionView = DynamicCollectionView(collectionType: .user, in: self, using: dao)
        setupCollectionViewConstraints()
    }

    func setupCollectionViewConstraints() {
        guard let presetsCollectionView = presetsCollectionView else { return }
        view.addSubview(presetsCollectionView)
        presetsCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            presetsCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 30),
            presetsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            presetsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            presetsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
