//
//  UIViewController.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 19/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

extension UIViewController {

    func presentLoadingScreen() {
        let loadingScreen = UIViewController()
        loadingScreen.modalPresentationStyle = .overFullScreen
        loadingScreen.modalTransitionStyle = .crossDissolve
        loadingScreen.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.75)

        let activityIndicator = UIActivityIndicatorView(style: .medium)
        loadingScreen.view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: loadingScreen.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loadingScreen.view.centerYAnchor)
        ])
        activityIndicator.startAnimating()
        activityIndicator.tintColor = .black

        DispatchQueue.main.async { [weak self] in self?.present(loadingScreen, animated: true)}
    }

    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func add(_ child: UIViewController, on view: UIView) {
        addChild(child)

        view.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            child.view.topAnchor.constraint(equalTo: view.topAnchor),
            child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        child.didMove(toParent: self)
    }

    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
