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
        let dao = DynamicCollectionViewDAO(with: DAO.shared.presets)
        collectionView?.dao = dao

        DispatchQueue.main.async { [weak self] in
            self?.collectionView?.reloadData()
        }
    }
}

extension DiscoverViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let collectionView = collectionView else { return }

        let query = searchController.searchBar.text ?? ""
        collectionView.dao.filterPresets(withQuery: query)
        collectionView.reloadData()
    }
}
