//
//  ImagesPageViewController.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 19/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class ImagesPageViewController: UIPageViewController, UIPageViewControllerDelegate {

    let imagesURLs: [URL?]
    var pageControl = UIPageControl()
    var pageControlView: UIView

    lazy var pages: [UIViewController] = {
        return self.imagesURLs.map { PresetImageViewController(withImageURL: $0) }
    }()

    init(withImagesURLs imagesURLs: [URL?], pageControlView: UIView) {
        self.imagesURLs = imagesURLs
        self.pageControlView = pageControlView

        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        self.dataSource = self
        configurePageControl()
    }

    required init?(coder: NSCoder) {
        self.imagesURLs = []
        self.pageControlView = UIView()

        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        self.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }

    func configurePageControl() {
        pageControl = UIPageControl(frame: .zero)
        self.pageControl.numberOfPages = pages.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.5)
        self.pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.pageControl.isUserInteractionEnabled = false

        pageControlView.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            pageControl.leadingAnchor.constraint(equalTo: pageControlView.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: pageControlView.trailingAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 50),
            pageControl.centerYAnchor.constraint(equalTo: pageControlView.centerYAnchor)
        ])
    }

    func goToNextPage(animated: Bool = true) {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) else { return }
        setViewControllers([nextViewController], direction: .forward, animated: animated, completion: nil)
    }

    func goToPreviousPage(animated: Bool = true) {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let previousViewController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) else { return }
        setViewControllers([previousViewController], direction: .reverse, animated: animated, completion: nil)
    }
}

extension ImagesPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else { return nil }

        guard pages.count > previousIndex else { return nil }

        self.pageControl.currentPage = previousIndex

        return pages[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }

        let nextIndex = viewControllerIndex + 1

        guard nextIndex < pages.count else { return nil }

        guard pages.count > nextIndex else { return nil }

        self.pageControl.currentPage = nextIndex

        return pages[nextIndex]
    }
}
