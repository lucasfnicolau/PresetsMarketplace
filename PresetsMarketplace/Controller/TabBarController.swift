//
//  TabBarController.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 18/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    let feedViewController = FeedViewController()
    let discoverViewController = DiscoverViewController()
    let profileViewController = ProfileViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        feedViewController.tabBarItem = UITabBarItem(title: "Feed", image: #imageLiteral(resourceName: "feed_outline"), selectedImage: #imageLiteral(resourceName: "feed_selected"))
    }
}
