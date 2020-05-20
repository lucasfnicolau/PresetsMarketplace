//
//  PresetInfoTableViewDataSource.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 20/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class PresetInfoTableViewDataSource: NSObject, UITableViewDataSource {
    let tableView: UITableView
    let preset: Preset

    init(for tableView: UITableView, with preset: Preset) {
        self.tableView = tableView
        self.preset = preset
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 0:
            return getSlideToMoreInfoCell()
        case 1:
            return getAboutPresetTableViewCell()
        case 2:
            return getArtistPresetTableViewCell()
        case 3:
            return getOthersPresetsTableViewCell()
        default:
            let emptyCell = UITableViewCell()
            emptyCell.backgroundColor = .clear
            return emptyCell
        }
    }
}

extension PresetInfoTableViewDataSource {

    func getSlideToMoreInfoCell() -> UITableViewCell {
        if let slideToMoreInfoCell = tableView.dequeueReusableCell(withIdentifier: Identifier.slideToMoreDetailsTableViewCell) as? SlideToMoreDetailsTableViewCell {

            return slideToMoreInfoCell
        }
        return UITableViewCell()
    }

    func getAboutPresetTableViewCell() -> UITableViewCell {
        if let aboutPresetTableViewCell = tableView.dequeueReusableCell(withIdentifier: Identifier.aboutPresetTableViewCell) as? AboutPresetTableViewCell {

            aboutPresetTableViewCell.setLayout(forDescription: preset.description)
            return aboutPresetTableViewCell
        }
        return UITableViewCell()
    }

    func getArtistPresetTableViewCell() -> UITableViewCell {
        if let artistPresetTableViewCell = tableView.dequeueReusableCell(withIdentifier: Identifier.artistPresetTableViewCell) as? ArtistPresetTableViewCell {

            artistPresetTableViewCell.setLayout(for: preset.artist)
            return artistPresetTableViewCell
        }
        return UITableViewCell()
    }

    func getOthersPresetsTableViewCell() -> UITableViewCell {
        if let othersPresetsTableViewCell = tableView.dequeueReusableCell(withIdentifier: Identifier.othersPresetsTableViewCell) as? OthersPresetsTableViewCell {

            return othersPresetsTableViewCell
        }
        return UITableViewCell()
    }
}
