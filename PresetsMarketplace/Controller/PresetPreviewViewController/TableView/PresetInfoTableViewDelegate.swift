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
    let blurView: UIVisualEffectView
    let slideToMoreInfoStackView: UIStackView

    init(for tableView: UITableView, with preset: Preset, with blurView: UIVisualEffectView, with slideToMoreInfoStackView: UIStackView) {
        self.tableView = tableView
        self.preset = preset
        self.blurView = blurView
        self.slideToMoreInfoStackView = slideToMoreInfoStackView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return UIScreen.main.bounds.height - HEADER_SIZE
        case 1:
            return max(CGFloat(230 * preset.description.count / 280), 100)
        case 2:
            return max(CGFloat(230 * preset.artist.about.count / 140), 170)
        case 3:
            return 260
        default:
            return 200
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        blurView.alpha = CGFloat(scrollView.contentOffset.y/500)
        
        if scrollView.contentOffset.y < 40 {
            slideToMoreInfoStackView.isHidden = false
        } else {
            slideToMoreInfoStackView.isHidden = true
        }
    }
}
