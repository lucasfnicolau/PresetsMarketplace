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

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .black
        tabBar.barTintColor = .white

        let feedNavigationController = UINavigationController(rootViewController: feedViewController)
        feedNavigationController.tabBarItem = UITabBarItem(title: "Feed",
                                                           image: #imageLiteral(resourceName: "feed_outline"),
                                                           selectedImage: #imageLiteral(resourceName: "feed_selected"))
        feedNavigationController.tabBarItem.tag = 0

        let discoverNavigationController = UINavigationController(rootViewController: discoverViewController)
        discoverNavigationController.tabBarItem = UITabBarItem(title: "Explorar",
                                                               image: #imageLiteral(resourceName: "discover_outline"),
                                                               selectedImage: #imageLiteral(resourceName: "discover_selected"))
        discoverNavigationController.tabBarItem.tag = 1


        guard let profileViewController = UIStoryboard(name: Storyboard.profileViewController, bundle: nil).instantiateViewController(identifier: Identifier.profileViewController) as? ProfileViewController else {
            return
        }

        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Perfil",
                                                              image: #imageLiteral(resourceName: "profile_outline"),
                                                              selectedImage: #imageLiteral(resourceName: "profile_selected"))
        profileNavigationController.tabBarItem.tag = 2

        viewControllers = [
            feedNavigationController,
            discoverNavigationController,
            profileNavigationController
        ]
    }
}
