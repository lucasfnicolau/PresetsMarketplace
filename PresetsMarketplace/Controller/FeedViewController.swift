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
    var dataSource: UICollectionViewDiffableDataSource<Section, Preset>?
    var isLoading = true

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Screen.feed

        DAO.shared.loadAllPresets()
        
        setupCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if isLoading {
            presentLoadingScreen()
        }
    }
    
    override func viewDidLayoutSubviews() {
        setupCollectionViewConstraints()
    }
    
    func setupCollectionView() {
        collectionView = DynamicCollectionView(collectionType: .user, in: self)
        guard let collectionView = collectionView else { return }
        self.view.addSubview(collectionView)

        setupCollectionViewDataSource()

        var filteredPresets = [Preset]()
        for _ in 0 ..< 4 {
            filteredPresets.append(Preset())
        }
        var snapshot = NSDiffableDataSourceSnapshot<Section, Preset>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filteredPresets)
        DispatchQueue.main.async { [weak self] in
            self?.dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }

    func setupCollectionViewDataSource() {
        guard let collectionView = collectionView else { return }

        dataSource = UICollectionViewDiffableDataSource<Section, Preset>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, preset) -> UICollectionViewCell? in

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.dynamicCollectionViewCell, for: indexPath) as? DynamicCollectionViewCell else {
                return UICollectionViewCell()
            }

            cell.setup(for: preset)
            return cell
        })
    }
    
    func setupCollectionViewConstraints() {
        guard let collectionView = collectionView else { return }
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
    }
    
    func getFollowingArtistsPresets() -> [Preset] {
        guard let user = DAO.shared.user else { return [] }
        var filteredPresets: [Preset] = []
        for artist in user.following {
            filteredPresets.append(contentsOf: DAO.shared.presets.filter { $0.artist == artist })
        }
        return filteredPresets
    }

    override func configureObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(dataFetched(_:)), name: NotificationName.feedDataFetched, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dataFetched(_:)), name: NotificationName.discoverDataFetched, object: nil)
    }

    @objc override func dataFetched(_ notif: Notification) {
        if isLoading {
            isLoading = false
            DispatchQueue.main.async { [weak self] in self?.dismiss(animated: true) }
        }

        let filteredPresets = getFollowingArtistsPresets()
        let dao = DynamicCollectionViewDAO(with: filteredPresets)
        collectionView?.dao = dao

        var snapshot = NSDiffableDataSourceSnapshot<Section, Preset>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filteredPresets)
        DispatchQueue.main.async { [weak self] in
            self?.dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }
}
