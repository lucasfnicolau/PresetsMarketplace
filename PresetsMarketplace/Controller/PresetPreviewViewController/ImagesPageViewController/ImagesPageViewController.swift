//
//  ImagesPageViewController.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 19/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class ImagesPageViewController: UIPageViewController {

    let imagesURLs: [URL?]

    lazy var pages: [UIViewController] = {
        return self.imagesURLs.map { PresetImageViewController(withImageURL: $0) }
    }()

    init(withImagesURLs imagesURLs: [URL?]) {
        self.imagesURLs = imagesURLs
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        self.imagesURLs = []
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
}
