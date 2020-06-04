//
//  BaseViewController.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 18/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    func setupLayout() {
        navigationController?.navigationBar.barTintColor = .white
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
