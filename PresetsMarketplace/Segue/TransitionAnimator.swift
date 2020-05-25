//
//  TransitionAnimator.swift
//  PresetsMarketplace
//
//  Created by Leonardo Oliveira on 22/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import Foundation
import UIKit

class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration: TimeInterval = 1
    var presenting: Bool = true
    var originFrame: CGRect = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        guard let toView = transitionContext.view(forKey: .to), 
            let destinationView = presenting ? toView : transitionContext.view(forKey: .from) else {
                print("Fail to get toView and destinationView")
                return
        }
        
        let frames = setFrames(from: destinationView)
        let scaleTransform = setScaleTransform(frames.initial, frames.final)
        
        configureDestinationView(destinationView, with: scaleTransform, with: frames)
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(destinationView)

        UIView.animate(
          withDuration: duration,
          delay: 0.0,
          usingSpringWithDamping: 0.8,
          initialSpringVelocity: 0.2,
          animations: { self.setAnimations(for: destinationView, with: scaleTransform, to: frames.final) }, 
          completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
    
    // MARK: - Auxiliar methods
    
    func setFrames(from view: UIView) -> (initial: CGRect, final: CGRect) {
        
        var initialFrame: CGRect
        var finalFrame: CGRect
        
        if presenting {
            initialFrame = originFrame
            finalFrame = view.frame
        } else {
            initialFrame = view.frame
            finalFrame = originFrame
        }
        
        return (initial: initialFrame, final: finalFrame)
    }
    
    func setScaleTransform(_ initial: CGRect, _ final: CGRect) -> CGAffineTransform {
        
        var xScaleFactor: CGFloat
        var yScaleFactor: CGFloat
        
        if presenting {
            xScaleFactor = initial.width / final.width
            yScaleFactor = initial.height / final.height
        } else {
            xScaleFactor = final.width / initial.width
            yScaleFactor = final.height / initial.height
        }
        
        return CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
    }
    
    func configureDestinationView(_ destinationView: UIView, with scaleTransform: CGAffineTransform, with frames: (initial: CGRect, final: CGRect)) {
        
        if presenting {
          destinationView.transform = scaleTransform
          destinationView.center = CGPoint(x: frames.initial.midX, y: frames.final.midY)
          destinationView.clipsToBounds = true
        }
        
        destinationView.layer.cornerRadius = presenting ? 20.0 : 0.0
        destinationView.layer.masksToBounds = true
    }
    
    func setAnimations(for view: UIView, with scaleTransform: CGAffineTransform, to frame: CGRect) {
        
        if presenting {
            view.transform = .identity
            view.layer.cornerRadius = 0.0
        } else {
            view.transform = scaleTransform
            view.layer.cornerRadius = 20.0
        }
        
        view.center = CGPoint(x: frame.midX, y: frame.midY)
    }
}
