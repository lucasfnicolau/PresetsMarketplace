//
//  FeedViewController.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 18/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class FeedViewController: BaseViewController {

    let transition = TransitionAnimator()
    var collectionView: DynamicCollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Screen.feed
        
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        setupCollectionViewConstraints()
    }
    
    func setupCollectionView() {
        collectionView = DynamicCollectionView(collectionType: .user, in: self)
        guard let collectionView = collectionView else { return }
        self.view.addSubview(collectionView)

        let filteredPresets = Array(repeating: Preset(), count: 4)
        let dao = DynamicCollectionViewDAO(with: filteredPresets)
        collectionView.dao = dao
    }
    
    func setupCollectionViewConstraints() {
        guard let collectionView = collectionView else { return }
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0)
        ])
    }
    
    func getFollowingArtistsPresets() -> [Preset] {
        guard let user = DAO.shared.user else { return [] }
        var filteredPresets: [Preset] = []
        for artist in user.following {
            filteredPresets += artist.presets
        }
        return filteredPresets
    }

    override func configureObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(dataFetched(_:)), name: NotificationName.feedDataFetched, object: nil)
    }

    @objc override func dataFetched(_ notif: Notification) {
        if let item = notif.userInfo?["item"] as? Int {
            let filteredPresets = getFollowingArtistsPresets()
            let dao = DynamicCollectionViewDAO(with: filteredPresets)
            collectionView?.dao = dao

            DispatchQueue.main.async { [weak self] in
                let indexPath = IndexPath(row: item, section: 0)
                self?.collectionView?.reloadData()
                self?.collectionView?.insertItems(at: [indexPath])
            }
        }
    }
}
