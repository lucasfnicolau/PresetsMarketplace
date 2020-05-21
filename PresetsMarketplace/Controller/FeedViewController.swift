//
//  FeedViewController.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 18/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class FeedViewController: BaseViewController {
    
    let collectionView = DynamicCollectionView(collectionType: .artist)

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Feed"
        
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        setupCollectionViewConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
//        let vc = PresetPreviewViewController()
//        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    func setupCollectionView() {
        self.view.addSubview(collectionView)
    }
    
    func setupCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0)
        ])
        
        collectionView.backgroundColor = .clear
    }
}
