//
//  PublicProfileViewController.swift
//  PresetsMarketplace
//
//  Created by Pedro Henrique Guedes Silveira on 25/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class PublicProfileViewController: UIViewController {
    
    var artistProfile: Artist = Artist(name: "MockedArtist", about: "MockedArtist", profileImageLink: "Falar com o Lucas")
    var userProfile: User = User(name: "MockedUser", profileImageLink: "Falar com o lucas")
    var profilePhotoImageView: UIImageView = UIImageView()
    var profileNameLabel: UILabel = UILabel()
    var profileDescriptionLabel: UILabel = UILabel()
    
    let followButton: UIButton = UIButton(type: .custom)
    
    var collectionView: DynamicCollectionView?

    override func viewDidLoad() {
        view.backgroundColor = .white
        setupImageView()
        setupLabels()
        setupButton()
        setupCollectionView()
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        setupImageConstraints()
        setupLabelsConstraints()
        setupButtonConstraint()
        setupCollectionViewConstraints()
    }
    
    func setupLabels() {
        profileNameLabel.text = artistProfile.name
        profileDescriptionLabel.text = artistProfile.about
        self.view.addSubview(profileNameLabel)
        self.view.addSubview(profileDescriptionLabel)
    }
    
    func setupLabelsConstraints() {
        profileNameLabel.translatesAutoresizingMaskIntoConstraints = false
        profileDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileNameLabel.topAnchor.constraint(equalTo: profilePhotoImageView.bottomAnchor, constant: 60),
            profileNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileDescriptionLabel.topAnchor.constraint(equalTo: profileNameLabel.bottomAnchor, constant: 18),
            profileDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupImageView() {
        guard let imageUrl = artistProfile.profileImageUrl else {
            return
        }
        profilePhotoImageView.load(url: imageUrl)
    }
    
    func setupImageConstraints() {
        
        let size = self.view.frame.size.width * 0.328
        profilePhotoImageView.layer.masksToBounds = true
        profilePhotoImageView.layer.cornerRadius = size / 2
        self.view.addSubview(profilePhotoImageView)
        profilePhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profilePhotoImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 70),
            profilePhotoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            profilePhotoImageView.widthAnchor.constraint(equalToConstant: size),
            profilePhotoImageView.heightAnchor.constraint(equalToConstant: size)
        ])
    }
    
    func setupButton() {
        if userProfile.following == [], !userProfile.following.contains(artistProfile) {
            let image = #imageLiteral(resourceName: "UnactiveFollowingBtn")
            followButton.setBackgroundImage(image, for: .normal)
            startFollowingButton()
        }
        
        if userProfile.following.contains(artistProfile) {
            let image = #imageLiteral(resourceName: "profile_selected")
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
    
    func startFollowingButton() {
        if followButton.target(forAction: #selector(stopFollowing), withSender: (Any).self) != nil {
            followButton.removeTarget(self, action: #selector(stopFollowing), for: .allTouchEvents)
        }

        followButton.addTarget(self, action: #selector(startFollowing), for: .touchDown)
    }
    
    func stopFollowingButton() {
        if followButton.target(forAction: #selector(startFollowing), withSender: (Any).self) != nil {
            followButton.removeTarget(self, action: #selector(startFollowing), for: .allTouchEvents)
        }

        followButton.addTarget(self, action: #selector(stopFollowing), for: .touchDown)
    }
    
    func setupCollectionView() {
        collectionView = DynamicCollectionView(collectionType: .artist, in: self)
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
        userProfile.startFollowing(artirt: artistProfile)
        let image = #imageLiteral(resourceName: "ActiveFollowingBtn")
        followButton.setBackgroundImage(image, for: .normal)
        stopFollowingButton()
    }
    
    @objc func stopFollowing() {
        userProfile.stopFollowing(artist: artistProfile)
        let image = #imageLiteral(resourceName: "UnactiveFollowingBtn")
        followButton.setBackgroundImage(image, for: .normal)
        startFollowingButton()
    }
}
