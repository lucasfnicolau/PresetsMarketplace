//
//  DynamicCollectionViewDAO.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 25/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import Foundation

class DynamicCollectionViewDAO: NSObject {
    private var presets: [Preset] = Mock.shared.presets
    var filteredPresets: [Preset] = Mock.shared.presets

    func filterPresets(withQuery query: String) {
        let formattedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        if formattedQuery.count == 0 {
            self.filteredPresets = self.presets
        } else {
            self.filteredPresets = self.presets.filter {
                $0.name.lowercased().contains(formattedQuery) || $0.artist.name.lowercased().contains(formattedQuery)
            }
        }
    }
}
