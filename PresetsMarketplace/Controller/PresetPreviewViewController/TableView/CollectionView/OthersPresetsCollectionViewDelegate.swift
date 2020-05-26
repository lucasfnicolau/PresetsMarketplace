//
//  OthersPresetsCollectionViewDelegate.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 21/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class OthersPresetsCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var presets: [Preset]
    let viewController: UIViewController

    init(with presets: [Preset], fromViewController viewController: UIViewController) {
        self.presets = presets
        self.viewController = viewController
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let presetPreviewViewController = UIStoryboard(name: Storyboard.presetPreviewViewController, bundle: nil).instantiateViewController(identifier: Identifier.presetPreviewViewController) as? PresetPreviewViewController {

            presetPreviewViewController.modalPresentationStyle = .fullScreen
            presetPreviewViewController.preset = presets[indexPath.item]
            viewController.present(presetPreviewViewController, animated: true, completion: nil)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 300, height: 200)
    }
}
