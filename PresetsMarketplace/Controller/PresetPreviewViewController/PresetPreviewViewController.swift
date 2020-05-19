//
//  PresetPreviewViewController.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 19/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class PresetPreviewViewController: UIViewController {
    @IBOutlet weak var presetNameLabel: UILabel!
    @IBOutlet weak var presetArtistNameLabel: UILabel!
    @IBOutlet weak var pageViewControllerView: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!

    // MARK: - Floating Selling Card
    @IBOutlet weak var floatingPresetNameLabel: UILabel!
    @IBOutlet weak var floatingSoldLabel: UILabel!
    @IBOutlet weak var floatingViewsLabel: UILabel!
    @IBOutlet weak var floatingBuyButton: UIButton!
    var preset: Preset?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func setupFloatingSellingCard() {

    }

    @IBAction func floatingBuyButtonTouched(_ sender: Any) {
    }

    @IBAction func closeButtonTouched(_ sender: Any) {
    }
}
