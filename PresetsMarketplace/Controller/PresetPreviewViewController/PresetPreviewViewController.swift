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
        setupFloatingSellingCard()
    }

    func setupFloatingSellingCard() {
        guard let preset = preset else { return }
        floatingPresetNameLabel.text = preset.name
        floatingSoldLabel.text = "\(preset.soldCound)"
        floatingViewsLabel.text = "\(preset.viewsCount)"

        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let price = formatter.string(from: NSNumber(value: preset.price)) {
            floatingBuyButton.setTitle(price, for: .normal)
        }
    }

    @IBAction func floatingBuyButtonTouched(_ sender: Any) {
    }

    @IBAction func closeButtonTouched(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
