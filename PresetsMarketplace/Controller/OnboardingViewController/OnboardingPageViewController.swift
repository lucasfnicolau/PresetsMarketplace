//
//  OnboardingPageViewController.swift
//  PresetsMarketplace
//
//  Created by Leonardo Oliveira on 04/06/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    var pageControl = UIPageControl()

    lazy var pages: [UIViewController] = {
        
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        
        let vc1 = storyboard.instantiateViewController(withIdentifier: "Onboarding1")
        let vc2 = storyboard.instantiateViewController(withIdentifier: "Onboarding2")
        let vc3 = storyboard.instantiateViewController(withIdentifier: "Onboarding3")
        let vc4 = storyboard.instantiateViewController(withIdentifier: "Onboarding4")
        let vc5 = storyboard.instantiateViewController(withIdentifier: "Onboarding5")
        let vc6 = storyboard.instantiateViewController(withIdentifier: "Onboarding6")
        
        return [vc1, vc2, vc3, vc4, vc5, vc6]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        self.dataSource = self
        self.delegate = self
        configurePageControl()
    }

    func configurePageControl() {
        pageControl = UIPageControl(frame: .zero)
        self.pageControl.numberOfPages = pages.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.pageControl.isUserInteractionEnabled = false

        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            pageControl.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 50),
            pageControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
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

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else { return nil }

        guard pages.count > previousIndex else { return nil }

        return pages[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }

        let nextIndex = viewControllerIndex + 1

        guard nextIndex < pages.count else { return nil }

        guard pages.count > nextIndex else { return nil }

        return pages[nextIndex]
    }
}

extension OnboardingPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = pages.firstIndex(of: pageContentViewController)!
    }
}
