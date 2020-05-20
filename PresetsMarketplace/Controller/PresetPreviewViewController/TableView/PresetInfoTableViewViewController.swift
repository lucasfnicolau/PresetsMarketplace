

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
    var presetInfoTableViewDataSource: PresetInfoTableViewDataSource?
    var presetInfoTableViewDelegate: PresetInfoTableViewDelegate?
    var preset: Preset?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let preset = preset else { return }
        presetInfoTableViewDataSource = PresetInfoTableViewDataSource(for: tableView, with: preset)
        presetInfoTableViewDelegate = PresetInfoTableViewDelegate(for: tableView, with: preset)
        tableView.dataSource = presetInfoTableViewDataSource
        tableView.delegate = presetInfoTableViewDelegate
        tableView.reloadData()
    }
}
