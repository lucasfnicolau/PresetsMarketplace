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
    
    var preset: Preset?

//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: "PresetPreviewViewController", bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(nibName: "PresetPreviewViewController", bundle: nil)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewComtroller()
//        setupFloatingSellingCard()
    }

    func setupPageViewComtroller() {
        guard let preset = preset else { return }
        let pageViewController = ImagesPageViewController(withImagesURLs: preset.imagesURLs)
        add(pageViewController, on: pageViewControllerView)
    }

//    func setupFloatingSellingCard() {
//        guard let preset = preset else { return }
//        floatingPresetNameLabel.text = preset.name
//        floatingSoldLabel.text = "\(preset.soldCount)"
//        floatingViewsLabel.text = "\(preset.viewsCount)"
//
//        let formatter = NumberFormatter()
//        formatter.locale = Locale.current
//        formatter.numberStyle = .currency
//        if let price = formatter.string(from: NSNumber(value: preset.price)) {
//            floatingBuyButton.setTitle(price, for: .normal)
//        }
//    }

    @IBAction func floatingBuyButtonTouched(_ sender: Any) {
    }

    @IBAction func closeButtonTouched(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
