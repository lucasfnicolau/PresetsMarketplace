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
    var viewController: UIViewController?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    func setButtonState() {
        guard let preset = preset else { return }
        if Mock.shared.user.hasPreset(preset) {
            floatingBuyButton.setTitle("ABRIR", for: .normal)
        } else {
            floatingBuyButton.setTitle("OBTER", for: .normal)
        }
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
        setButtonState()

//        let formatter = NumberFormatter()
//        formatter.locale = Locale.current
//        formatter.numberStyle = .currency
//        if let price = formatter.string(from: NSNumber(value: preset.price)) {
//            floatingBuyButton.setTitle(price, for: .normal)
//        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let presetInfoTableViewViewController = segue.destination as? PresetInfoTableViewViewController {
            presetInfoTableViewViewController.preset = preset
            presetInfoTableViewViewController.viewController = viewController
            presetInfoTableViewViewController.blurView = blurView
            presetInfoTableViewViewController.slideToMoreInfoStackView = slideToMoreInfoStackView
        }
    }

    @IBAction func floatingBuyButtonTouched(_ sender: Any) {
        guard let preset = preset else { return }
        if !Mock.shared.user.hasPreset(preset) {
            Mock.shared.user.addPreset(preset)
            setButtonState()

        } else {
            guard let url = Bundle.main.url(forResource: preset.dngPath, withExtension: "dng") else {
                return
            }
            do {
                let data = try Data(contentsOf: url)
                let activityViewController = UIActivityViewController(activityItems: [data], applicationActivities: nil)
                self.present(activityViewController, animated: true, completion: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    @IBAction func closeButtonTouched(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
