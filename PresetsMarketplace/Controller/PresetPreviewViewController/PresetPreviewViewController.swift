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
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var slideToMoreInfoStackView: UIStackView!
    @IBOutlet weak var pageViewControllerView: UIView!
    var imagesPageViewController: ImagesPageViewController!

    // MARK: - Floating Selling Card
    @IBOutlet weak var floatingPresetNameLabel: UILabel!
    @IBOutlet weak var floatingSoldLabel: UILabel!
    @IBOutlet weak var floatingViewsLabel: UILabel!
    @IBOutlet weak var floatingBuyButton: UIButton!
    var preset: Preset?
    
    var transitionDelegate: TransitionDelegate?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        transitionDelegate = TransitionDelegate()
        self.transitioningDelegate = transitionDelegate
        
        setupViews()
        setupPageViewController()
        setupFloatingSellingCard()
        setupGesturesRecognizer()
    }

    func setupViews() {
        guard let preset = preset else { return }
        blurView.alpha = 0.0
        presetNameLabel.text = preset.name
        presetArtistNameLabel.text = "por \(preset.artist.name)"
    }

    func setupPageViewController() {
        guard let preset = preset else { return }
        imagesPageViewController = ImagesPageViewController(withImagesURLs: preset.imagesURLs)
        add(imagesPageViewController, on: pageViewControllerView)
    }

    func setupGesturesRecognizer() {
        let swipetToLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipe(gesture:)))
        swipetToLeftGesture.direction = .left

        let swipetToRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipe(gesture:)))

        view.addGestureRecognizer(swipetToLeftGesture)
        view.addGestureRecognizer(swipetToRightGesture)
    }

    @objc func swipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            imagesPageViewController.goToNextPage()
            break
        case .right:
            imagesPageViewController.goToPreviousPage()
            break
        default:
            return
        }
    }

    func setupFloatingSellingCard() {
        guard let preset = preset else { return }
        floatingPresetNameLabel.text = preset.name
        floatingSoldLabel.text = "\(preset.soldCount)"
        floatingViewsLabel.text = "\(preset.viewsCount)"

        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let price = formatter.string(from: NSNumber(value: preset.price)) {
            floatingBuyButton.setTitle(price, for: .normal)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let presetInfoTableViewViewController = segue.destination as? PresetInfoTableViewViewController {
            presetInfoTableViewViewController.preset = preset
            presetInfoTableViewViewController.blurView = blurView
            presetInfoTableViewViewController.slideToMoreInfoStackView = slideToMoreInfoStackView
        }
    }

    @IBAction func floatingBuyButtonTouched(_ sender: Any) {
    }

    @IBAction func closeButtonTouched(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
