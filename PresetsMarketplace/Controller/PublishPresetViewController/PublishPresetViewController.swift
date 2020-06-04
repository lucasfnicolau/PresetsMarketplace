//
//  PublishPresetViewController.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 04/06/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class PublishPresetViewController: UIViewController {

    @IBOutlet weak var backingImageView: UIImageView!
    @IBOutlet weak var blurView: UIVisualEffectView!

    var backingImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        backingImageView.image = backingImage
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
