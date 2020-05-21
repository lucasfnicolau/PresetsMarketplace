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
    var othersPresetsCollectionViewDelegate: OthersPresetsCollectionViewDelegate?
    var othersPresetsCollectionViewDataSource: OthersPresetsCollectionViewDataSource?

    init(for tableView: UITableView, with preset: Preset) {
        self.tableView = tableView
        self.preset = preset
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 1:
            return getAboutPresetTableViewCell()
        case 2:
            return getArtistPresetTableViewCell()
        case 3:
            return preset.artist.presets.count > 1 ? getOthersPresetsTableViewCell() : getEmptyCell()
        default:
            return getEmptyCell()
        }
    }
}

extension PresetInfoTableViewDataSource {

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

            configureOthersPresetsCollectionView(for: othersPresetsTableViewCell)
            return othersPresetsTableViewCell
        }
        return UITableViewCell()
    }

    func getEmptyCell() -> UITableViewCell {
        let emptyCell = UITableViewCell()
        emptyCell.backgroundColor = .clear
        emptyCell.selectionStyle = .none
        return emptyCell
    }

    func configureOthersPresetsCollectionView(for cell: OthersPresetsTableViewCell) {
        let othersPresets = preset.artist.presets.filter { $0 != preset }
        othersPresetsCollectionViewDelegate = OthersPresetsCollectionViewDelegate(with: othersPresets)
        othersPresetsCollectionViewDataSource = OthersPresetsCollectionViewDataSource(with: othersPresets)

        cell.othersPresetsCollectionView.delegate = othersPresetsCollectionViewDelegate
        cell.othersPresetsCollectionView.dataSource = othersPresetsCollectionViewDataSource
        cell.othersPresetsCollectionView.reloadData()
    }
}
