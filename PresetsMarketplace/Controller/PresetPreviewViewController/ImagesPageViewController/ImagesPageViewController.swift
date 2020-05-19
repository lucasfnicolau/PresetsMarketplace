//
//  ImagesPageViewController.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 19/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class ImagesPageViewController: UIPageViewController {

//    lazy var pages: [PresetImageViewController] = {
//        
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setImages(for imagesURLs: [URL?]) {
        imagesURLs.forEach { url in
            let viewController = UIViewController()

        }
    }

    func setupConstraints(for viewController: UIViewController) {

    }
}
