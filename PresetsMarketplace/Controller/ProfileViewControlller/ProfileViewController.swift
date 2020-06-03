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

        checkIfUserIsLoggedIn()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func checkIfUserIsLoggedIn() {
        if !DAO.shared.isLoggedIn {
            let loginViewController = LoginViewController()
            loginViewController.modalPresentationStyle = .custom
            self.present(loginViewController, animated: true, completion: nil)
        }
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

        self.profileImageView.image = UIImage(named: "profile_thumbnail_bg")
        setupLabel()
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

    func setupLabel() {
        let label = UILabel()
        label.font = label.font.withSize(75)
        label.textAlignment = .center
        label.textColor = .black

        profileImageView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor),
            label.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            label.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor)
        ])

        label.text = String(Mock.shared.user.name.prefix(1)).uppercased()
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

    override func configureObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(loadAcquiredPresets), name: NotificationName.userCreated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dataFetched(_:)), name: NotificationName.profileDataFetched, object: nil)

        loadAcquiredPresets()
    }

    @objc override func dataFetched(_ notif: Notification) {
        guard let user = DAO.shared.user else { return }
        let dao = DynamicCollectionViewDAO(with: user.acquiredPresets)
        presetsCollectionView?.dao = dao

        DispatchQueue.main.async { [weak self] in
            self?.noPresetsAcquiredLabel.isHidden = true
            self?.presetsCollectionView?.reloadData()
        }
    }

    @objc func loadAcquiredPresets() {
        DAO.shared.loadAcquiredPresets()
    }
}
