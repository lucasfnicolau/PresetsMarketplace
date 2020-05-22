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
        let artist = Artist(name: "Dagoberto",
                            about: "Ex-futebolista",
                            profileImageLink: "https://dragoesdareal.com.br/vps/wp-content/uploads/2017/03/Dagoberto-170321.jpg")

        let preset = Preset(name: "Summer Set",
                            artist: artist,
                            description: "Cores quentes",
                            price: 422.10,
                            imagesLinks: [
                                "https://greekcitytimes.com/wp-content/uploads/2020/04/elena-ktenopoulou-cjzV4WK46qY-unsplash-scaled.jpg",
                                "https://www.highreshdwallpapers.com/wp-content/uploads/2011/07/High-resolution-football-wallpaper.jpg"
        ])

        let preset2 = Preset(name: "Dagol da galera",
                            artist: artist,
                            description: "Vixe",
                            price: 100,
                            imagesLinks: [
                                "https://www.highreshdwallpapers.com/wp-content/uploads/2011/07/High-resolution-football-wallpaper.jpg",
                                "https://greekcitytimes.com/wp-content/uploads/2020/04/elena-ktenopoulou-cjzV4WK46qY-unsplash-scaled.jpg"
        ])

        let preset3 = Preset(name: "Biruta",
                             artist: artist,
                             description: "Oh yeah",
                             price: 90,
                             imagesLinks: [
                                "https://miro.medium.com/max/1400/1*UpYip0hMzt2uGfaGaMdQXw.jpeg"
        ])

        artist.presets = [preset, preset2, preset3]

        if let vc = UIStoryboard(name: Storyboard.presetPreviewViewController, bundle: nil).instantiateViewController(identifier: Identifier.presetPreviewViewController) as? PresetPreviewViewController {
            vc.preset = preset
            vc.modalPresentationStyle = .fullScreen
            navigationController?.present(vc, animated: true, completion: nil)
        }
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
