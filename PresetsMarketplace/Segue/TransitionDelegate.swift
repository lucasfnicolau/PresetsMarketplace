//
//  TransitionDelegate.swift
//  PresetsMarketplace
//
//  Created by Leonardo Oliveira on 22/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class TransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var transition = TransitionAnimator()
    var originFrame: CGRect = .zero
    var destinationFrame: CGRect = .zero
    var imageView: UIImageView = .init(frame: .zero)
    
    init(from originFrame: CGRect? = nil, to destinationFrame: CGRect? = nil, with imageView: UIImageView) {
        
        self.imageView = imageView
        
        if let origin = originFrame {
            self.originFrame = origin
        }
        
        if let destination = destinationFrame {
            self.destinationFrame = destination
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.originFrame = originFrame
        transition.imageView = imageView
        transition.presenting = true
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.originFrame = destinationFrame
        transition.imageView = imageView
        transition.presenting = false
        
        return transition
    }
}
