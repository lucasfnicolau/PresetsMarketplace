//
//  PresetInfoTableViewDelegate.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 20/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class PresetInfoTableViewDelegate: NSObject, UITableViewDelegate {
    let HEADER_SIZE: CGFloat = 96 + UIApplication.shared.statusBarFrame.height

    let tableView: UITableView
    let preset: Preset
    let heights: [CGFloat]

    init(for tableView: UITableView, with preset: Preset) {
        self.tableView = tableView
        self.preset = preset

        heights = [
            UIScreen.main.bounds.height - HEADER_SIZE,
            400
        ]
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row > 0 ? 400 : heights[0]
    }
}
