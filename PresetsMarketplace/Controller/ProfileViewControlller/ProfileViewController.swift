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
    @IBOutlet weak var noPresetsAcquiredLabel: UILabel!
    var presetsCollectionView: DynamicCollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Screen.profile
        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !Mock.shared.user.acquiredPresets.isEmpty {
            noPresetsAcquiredLabel.isHidden = true
        }

        presetsCollectionView?.dao = DynamicCollectionViewDAO(with: Mock.shared.user.acquiredPresets)
        presetsCollectionView?.reloadData()
    }

    func setupViews() {
        artistNameLabel.text = Mock.shared.user.name
        if let artist = Mock.shared.user as? Artist {
            artistAboutLabel.text = artist.about
        }

//        profileImageView.load(url: Mock.shared.user.profileImageUrl) { _ in
//            let size: CGFloat = 125
//            self.profileImageView.layer.cornerRadius = size / 2
//            NSLayoutConstraint.activate([
//                self.profileImageView.widthAnchor.constraint(equalToConstant: size),
//                self.profileImageView.heightAnchor.constraint(equalToConstant: size)
//            ])
//        }

        self.profileImageView.image = UIImage(named: "mock_profile")
        let size: CGFloat = 125
        self.profileImageView.layer.cornerRadius = size / 2
        NSLayoutConstraint.activate([
            self.profileImageView.widthAnchor.constraint(equalToConstant: size),
            self.profileImageView.heightAnchor.constraint(equalToConstant: size)
        ])

        let dao = DynamicCollectionViewDAO(with: Mock.shared.user.acquiredPresets)
        presetsCollectionView = DynamicCollectionView(collectionType: .user, in: self, using: dao)
        setupCollectionViewConstraints()
    }

    func setupCollectionViewConstraints() {
        guard let presetsCollectionView = presetsCollectionView else { return }
        view.addSubview(presetsCollectionView)
        presetsCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            presetsCollectionView.topAnchor.constraint(equalTo: artistInfoStackView.bottomAnchor, constant: 30),
            presetsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            presetsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            presetsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
