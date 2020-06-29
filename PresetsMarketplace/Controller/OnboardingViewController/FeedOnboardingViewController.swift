//
//  FeedOnboardingViewController.swift
//  PresetsMarketplace
//
//  Created by Leonardo Oliveira on 04/06/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class FeedOnboardingViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var animatedImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateArray()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.imageView.startAnimating()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.imageView.stopAnimating()
        }
    }
    
    func populateArray() {
        
        for i in 1...81 {
            
            guard let image = UIImage(named: "Feed-\(i)") else {
                return
            }
            animatedImages.append(image)
        }
        animate()
    }
    
    func animate() {
        
        imageView.animationImages = animatedImages
        imageView.animationDuration = 8
        imageView.animationRepeatCount = -1
    }

}
