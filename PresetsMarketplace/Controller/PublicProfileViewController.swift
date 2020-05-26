//
//  PublicProfileViewController.swift
//  PresetsMarketplace
//
//  Created by Pedro Henrique Guedes Silveira on 25/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class PublicProfileViewController: UIViewController {

    var profilePhotoImageView: UIImageView = UIImageView()
    var profileNameLabel: UILabel = UILabel()
    var profileDescriptionLabel: UILabel = UILabel()
    var artist: Artist?
    
    let followButton: UIButton = UIButton(type: .custom)
    let closeButton: UIButton = UIButton(type: .custom)
    
    var collectionView: DynamicCollectionView?
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupImageView()
        setupLabels()
        setupFollowButton()
        setupCollectionView()
        setupCloseButton()
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        setupImageConstraints()
        setupLabelsConstraints()
        setupButtonConstraint()
        setupCollectionViewConstraints()
        setupCloseButtonConstraints()
    }
    
    func setupLabels() {
        guard let artist = artist else { return }
        profileNameLabel.text = artist.name
        profileNameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        profileDescriptionLabel.text = artist.about
        self.view.addSubview(profileNameLabel)
        self.view.addSubview(profileDescriptionLabel)
    }
    
    func setupLabelsConstraints() {
        profileNameLabel.translatesAutoresizingMaskIntoConstraints = false
        profileDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        profileDescriptionLabel.numberOfLines = 0
        profileDescriptionLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            profileNameLabel.topAnchor.constraint(equalTo: profilePhotoImageView.bottomAnchor, constant: 60),
            profileNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileDescriptionLabel.topAnchor.constraint(equalTo: profileNameLabel.bottomAnchor, constant: 18),
            profileDescriptionLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            profileDescriptionLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            profileDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupImageView() {
        guard let artist = artist else { return }
        guard let imageUrl = artist.profileImageUrl else {
            return
        }
        profilePhotoImageView.load(url: imageUrl)
        profilePhotoImageView.contentMode = .scaleAspectFill
    }
    
    func setupImageConstraints() {
        
        let size = self.view.frame.size.width * 0.328
        profilePhotoImageView.layer.masksToBounds = true
        profilePhotoImageView.layer.cornerRadius = size / 2
        self.view.addSubview(profilePhotoImageView)
        profilePhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profilePhotoImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 70),
            profilePhotoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            profilePhotoImageView.widthAnchor.constraint(equalToConstant: size),
            profilePhotoImageView.heightAnchor.constraint(equalToConstant: size)
        ])
    }
    
    func setupFollowButton() {
        guard let artist = artist else { return }
        if !Mock.shared.user.following.contains(artist) {
            let image = #imageLiteral(resourceName: "UnactiveFollowingBtn")
            followButton.setBackgroundImage(image, for: .normal)
            startFollowingButton()
        } else if Mock.shared.user.following.contains(artist) {
            let image = #imageLiteral(resourceName: "ActiveFollowingBtn")
            followButton.setBackgroundImage(image, for: .normal)
            stopFollowingButton()
        }
        view.addSubview(followButton)
    }
    
    func setupButtonConstraint() {
        
        let widht = view.frame.size.width * 0.232
        let height = widht * 0.333
        
        followButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            followButton.topAnchor.constraint(equalTo: profileDescriptionLabel.bottomAnchor, constant: 30),
            followButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            followButton.widthAnchor.constraint(equalToConstant: widht),
            followButton.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    func setupCloseButton() {
        let image = #imageLiteral(resourceName: "close_btn")
        
        closeButton.setImage(image, for: .normal)
        closeButton.addTarget(self, action: #selector(selfDismiss), for: .touchUpInside)
        self.view.addSubview(closeButton)
    }
    
    func setupCloseButtonConstraints() {
        
        let size = self.view.frame.width * 0.1
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: size),
            closeButton.heightAnchor.constraint(equalToConstant: size)
        ])
    }
    
    func startFollowingButton() {
        if followButton.target(forAction: #selector(stopFollowing), withSender: (Any).self) != nil {
            followButton.removeTarget(self, action: #selector(stopFollowing), for: .allTouchEvents)
        }

        followButton.addTarget(self, action: #selector(startFollowing), for: .touchUpInside)
    }
    
    func stopFollowingButton() {
        if followButton.target(forAction: #selector(startFollowing), withSender: (Any).self) != nil {
            followButton.removeTarget(self, action: #selector(startFollowing), for: .allTouchEvents)
        }

        followButton.addTarget(self, action: #selector(stopFollowing), for: .touchUpInside)
    }
    
    func setupCollectionView() {
        guard let artist = artist else { return }
        let dao = DynamicCollectionViewDAO(with: artist.presets)
        collectionView = DynamicCollectionView(collectionType: .user, in: self, using: dao)
        guard let collectionView = collectionView else { return }
        self.view.addSubview(collectionView)
    }
    
    func setupCollectionViewConstraints() {
        guard let collectionView = collectionView else { return }
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: followButton.bottomAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0)
        ])
        collectionView.backgroundColor = .clear
    }
    
    @objc func startFollowing() {
        guard let artist = artist else { return }
        Mock.shared.user.startFollowing(artirt: artist)
        let image = #imageLiteral(resourceName: "ActiveFollowingBtn")
        followButton.setBackgroundImage(image, for: .normal)
        stopFollowingButton()
    }
    
    @objc func stopFollowing() {
        guard let artist = artist else { return }
        Mock.shared.user.stopFollowing(artist: artist)
        let image = #imageLiteral(resourceName: "UnactiveFollowingBtn")
        followButton.setBackgroundImage(image, for: .normal)
        startFollowingButton()
    }
    
    @objc func selfDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
