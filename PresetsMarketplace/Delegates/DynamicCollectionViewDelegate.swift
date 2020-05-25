//
//  DynamicCollectionViewDelegate.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 22/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class DynamicCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    private let dao: DynamicCollectionViewDAO
    weak var viewController: UIViewController?

    init(for dao: DynamicCollectionViewDAO, from viewController: UIViewController? = nil) {
        self.viewController = viewController
        self.dao = dao
        super.init()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        presentPresetPreview(from: collectionView, fromSelectedItemAt: indexPath)
    }
    
    // MARK: - Auxiliar functions
    
    func presentPresetPreview(from collectionView: UICollectionView, fromSelectedItemAt indexPath: IndexPath) {
        
        guard let viewController = viewController, 
            let navigationController = viewController.navigationController, 
            let cell = collectionView.cellForItem(at: indexPath) as? DynamicCollectionViewCell else {
            print("Error when guarding viewController or navigationController or cell")
            return
        }
        
        
        if let destination = UIStoryboard(name: Storyboard.presetPreviewViewController, bundle: nil).instantiateViewController(identifier: Identifier.presetPreviewViewController) as? PresetPreviewViewController {
            
            let originFrame = setOriginFrame(from: cell)
            let transitionDelegate = TransitionDelegate(from: originFrame)
            
            destination.transitioningDelegate = transitionDelegate
            destination.modalPresentationStyle = .fullScreen
            destination.preset = dao.filteredPresets[indexPath.item]
            
            navigationController.present(destination, animated: true, completion: nil)
        }
    }
    
    func setOriginFrame(from cell: DynamicCollectionViewCell) -> CGRect {
        
        var originFrame: CGRect = .zero
        
        guard let viewController = viewController, 
            let cellSuperView = cell.superview else {
            return .zero
        }
        
        
        originFrame = cellSuperView.convert(cell.frame, to: viewController.view)
        
        return originFrame
    }
}
