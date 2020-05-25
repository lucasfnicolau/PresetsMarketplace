//
//  DynamicCollectionViewDelegate.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 22/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class DynamicCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    private var presets: [Preset]
    weak var viewController: UIViewController?

    init(with presets: [Preset], from viewController: UIViewController) {
        self.viewController = viewController
        self.presets = presets
        super.init()
    }

    func updatePresets(to presets: [Preset]) {
        self.presets = presets
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Item: \(indexPath.item) | Row: \(indexPath.row) | Name: \(presets[indexPath.item].name)")
        
        presentPresetPreview(from: collectionView, fromSelectedItemAt: indexPath)
    }
    
    // MARK: - Auxiliar functions
    
    func presentPresetPreview(from collectionView: UICollectionView, fromSelectedItemAt indexPath: IndexPath) {
        
        guard let viewController = viewController, 
            let navigationController =  viewController.navigationController else {
            print("Error when guarding viewController or navigationController")
            return
        }
        
        viewController.modalPresentationStyle = .fullScreen
        
        let destination = PresetPreviewViewController()
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? DynamicCollectionViewCell else {
            return
        }
        
        let originFrame = setOriginFrame(from: cell)
        
        destination.transitionDelegate = TransitionDelegate(from: originFrame)
        navigationController.present(destination, animated: true, completion: nil) 
        
    }
    
    func setOriginFrame(from cell: DynamicCollectionViewCell) -> CGRect {
        
        var originFrame: CGRect = .zero
        
        guard let cellSuperView = cell.superview else {
            return .zero
        }
        
        originFrame = cellSuperView.convert(cell.frame, to: nil)
        
        return originFrame
    }
}
