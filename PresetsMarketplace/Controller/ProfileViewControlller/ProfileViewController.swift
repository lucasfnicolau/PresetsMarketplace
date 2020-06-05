//
//  ProfileViewController.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 18/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var artistInfoStackView: UIStackView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artistAboutLabel: UILabel!
    @IBOutlet weak var noPresetsAcquiredLabel: UILabel!
    var profileImageLabel: UILabel?
    var presetsCollectionView: DynamicCollectionView?
    
    var acquiredPresetsDAO: DynamicCollectionViewDAO?
    var publishedPresetsDAO: DynamicCollectionViewDAO?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Screen.profile
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(publishPreset))
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationController?.navigationBar.tintColor = .black

        setupViews()

        checkIfUserIsLoggedIn()
        
        DAO.shared.loadAllPresets()
        presetsCollectionView?.reloadData()
    }

    func checkIfUserIsLoggedIn() {
        if !DAO.shared.isLoggedIn {
            let loginViewController = LoginViewController()
            loginViewController.modalPresentationStyle = .custom
            self.present(loginViewController, animated: true, completion: nil)
        } else {
            loadAcquiredPresets()
        }
    }

    @objc private func publishPreset() {
        if let publishPresetTableViewController = UIStoryboard(name: Storyboard.publishPresetTableViewController, bundle: nil).instantiateViewController(identifier: Identifier.publishPresetTableViewController) as? PublishPresetTableViewController {

            self.present(publishPresetTableViewController, animated: true, completion: nil)
        }
    }

    private func setupViews() {
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
        
        guard let user = DAO.shared.user else { return }

        let acquiredDAO = DynamicCollectionViewDAO(with: user.acquiredPresets)
        presetsCollectionView = DynamicCollectionView(collectionType: .user, in: self, using: acquiredDAO)
        setupCollectionViewConstraints()
    }

    private func setupLabel() {
        profileImageLabel = UILabel()
        guard let profileImageLabel = profileImageLabel else { return }
        profileImageLabel.font = profileImageLabel.font.withSize(75)
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

    private func setupCollectionViewConstraints() {
        guard let presetsCollectionView = presetsCollectionView else { return }
        view.addSubview(presetsCollectionView)
        presetsCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            presetsCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 30),
            presetsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            presetsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            presetsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func configureObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(loadAcquiredPresets), name: NotificationName.userCreated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadPublishedPresets), name: NotificationName.userCreated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dataFetched(_:)), name: NotificationName.profileDataFetched, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dataFetched(_:)), name: NotificationName.discoverDataFetched, object: nil)

//        loadAcquiredPresets()
    }

    @objc override func dataFetched(_ notif: Notification) {
        guard let user = DAO.shared.user else { return }
        
        if notif.name == NotificationName.profileDataFetched {
            acquiredPresetsDAO = DynamicCollectionViewDAO(with: user.acquiredPresets)
        } else {
            let filteredPresets = DAO.shared.presets.filter {
                $0.artist.id == user.id
            }
            publishedPresetsDAO = DynamicCollectionViewDAO(with: filteredPresets)
        }
        DispatchQueue.main.async { [weak self] in
            self?.navigationItem.rightBarButtonItem?.isEnabled = true
            self?.noPresetsAcquiredLabel.isHidden = true
            self?.changeDAO(for: self?.segmentedControl.selectedSegmentIndex ?? 0)
        }
    }

    @objc private func loadAcquiredPresets() {
        DispatchQueue.main.async {
            self.artistNameLabel.text = DAO.shared.user?.name ?? Mock.shared.user.name
            let letter = DAO.shared.user?.name.prefix(1) ?? Mock.shared.user.name.prefix(1)
            self.profileImageLabel?.text = String(letter).uppercased()
        }
        DAO.shared.loadAcquiredPresets()
    }
    
    @objc private func loadPublishedPresets() {
//        DAO.shared.loadPublishedPresets()
    }
    
    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        changeDAO(for: sender.selectedSegmentIndex)
    }
    
    private func changeDAO(for sectionIndex: Int) {
        switch sectionIndex {
            case 0:
                guard let acquiredPresetsDAO = acquiredPresetsDAO else {
                    print("Could not get Acquired Presets DAO")
                    presetsCollectionView?.dao = DynamicCollectionViewDAO(with: [])
                    return
                }
                presetsCollectionView?.dao = acquiredPresetsDAO
                
            case 1:
                guard let publishedPresetsDAO = publishedPresetsDAO else {
                    print("Could not get Published Presets DAO")
                    presetsCollectionView?.dao = DynamicCollectionViewDAO(with: [])
                    return
                }
                presetsCollectionView?.dao = publishedPresetsDAO
            default:
                break
        }
        presetsCollectionView?.reloadData()
    }
    
    
}
