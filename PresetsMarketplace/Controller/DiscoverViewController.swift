//
//  DiscoverViewController.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 18/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class DiscoverViewController: BaseViewController {

    var collectionView: DynamicCollectionView?
    var dataSource: UICollectionViewDiffableDataSource<Section, Preset>?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Screen.discover

        DAO.shared.loadAllPresets()

        setupSearchController()
        setupCollectionView()
    }

    override func viewDidLayoutSubviews() {
        setupCollectionViewConstraints()
    }

    func setupCollectionView() {
        let presets = Array(repeating: Preset(), count: 4)
        let dao = DynamicCollectionViewDAO(with: presets)
        collectionView = DynamicCollectionView(collectionType: .user, in: self, using: dao)
        
        guard let collectionView = collectionView else { return }
        collectionView.reloadData()
        self.view.addSubview(collectionView)

        setupCollectionViewDataSource()

        var filteredPresets = [Preset]()
        for _ in 0 ..< 4 {
            filteredPresets.append(Preset())
        }
        updateData(with: filteredPresets)
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

    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Busque por artistas e presets"
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
    }

    override func configureObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(dataFetched(_:)), name: NotificationName.discoverDataFetched, object: nil)
    }

    @objc override func dataFetched(_ notif: Notification) {
        guard let user = DAO.shared.user else { return }
        let dao = DynamicCollectionViewDAO(with: DAO.shared.presets.filter { $0.artist.id != user.id })
        collectionView?.dao = dao

        updateData(with: dao.filteredPresets)
    }

    private func updateData(with items: [Preset])  {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Preset>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)

        DispatchQueue.main.async { [weak self] in
            self?.dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension DiscoverViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let collectionView = collectionView else { return }

        let query = searchController.searchBar.text ?? ""
        collectionView.dao.filterPresets(withQuery: query)

        updateData(with: collectionView.dao.filteredPresets)
    }
}
