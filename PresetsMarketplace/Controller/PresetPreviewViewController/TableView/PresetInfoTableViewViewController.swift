

//
//  PresetInfoTableViewViewController.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 20/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class PresetInfoTableViewViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var preset: Preset?
    var blurView: UIVisualEffectView?
    var slideToMoreInfoStackView: UIStackView?
    var presetInfoTableViewDataSource: PresetInfoTableViewDataSource?
    var presetInfoTableViewDelegate: PresetInfoTableViewDelegate?
    var viewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let preset = preset, 
            let blurView = blurView, 
            let slideToMoreInfoStackView = slideToMoreInfoStackView else {
            return
        }

        guard let viewController = viewController else { return }

        presetInfoTableViewDataSource = PresetInfoTableViewDataSource(for: tableView, with: preset, fromViewController: viewController)
        presetInfoTableViewDelegate = PresetInfoTableViewDelegate(for: tableView, with: preset, with: blurView, with: slideToMoreInfoStackView, from: viewController)
        tableView.dataSource = presetInfoTableViewDataSource
        tableView.delegate = presetInfoTableViewDelegate
        tableView.reloadData()
    }
}
