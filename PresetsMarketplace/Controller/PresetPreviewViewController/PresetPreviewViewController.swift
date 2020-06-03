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
    @IBOutlet weak var pageControlView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    var imagesPageViewController: ImagesPageViewController!

    // MARK: - Floating Selling Card
    @IBOutlet weak var floatingBlurView: RoundedBluredView!
    @IBOutlet weak var floatingPresetNameLabel: UILabel!
    @IBOutlet weak var floatingSoldLabel: UILabel!
    @IBOutlet weak var floatingViewsLabel: UILabel!
    @IBOutlet weak var floatingBuyButtonView: RoundedView!
    @IBOutlet weak var floatingBuyButton: UIButton!
    var preset: Preset?
  
    var transitionDelegate: TransitionDelegate?
    var origin: CGRect = .zero
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
    
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      
      UIView.animate(withDuration: 0.2) {
        self.presetNameLabel.alpha = 0
        self.presetArtistNameLabel.alpha = 0
        self.blurView.alpha = 0
        self.closeButton.alpha = 0
        self.slideToMoreInfoStackView.alpha = 0
        self.floatingBlurView.alpha = 0
        self.floatingPresetNameLabel.alpha = 0
        self.floatingSoldLabel.alpha = 0
        self.floatingViewsLabel.alpha = 0
        self.floatingBuyButton.alpha = 0
      }
    }

    func setupViews() {
        guard let preset = preset else { return }
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        blurView.alpha = 0.0
        presetNameLabel.text = preset.name
        presetArtistNameLabel.text = "por \(preset.artist.name)"
    }

    func setButtonState() {
        guard let preset = preset else { return }
        if Mock.shared.user.hasPreset(preset) {
            UIView.animate(withDuration: 0.1) {
                self.floatingBuyButtonView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.55)
                self.floatingBuyButton.setTitleColor(.white, for: .normal)
            }
            floatingBuyButton.setTitle("ABRIR", for: .normal)
        } else {
            UIView.animate(withDuration: 0.1) {
                self.floatingBuyButtonView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.55)
                self.floatingBuyButton.setTitleColor(.black, for: .normal)
            }
            floatingBuyButton.setTitle("OBTER", for: .normal)
        }
    }

    func setupPageViewController() {
        guard let preset = preset else { return }
        imagesPageViewController = ImagesPageViewController(withImagesURLs: preset.imagesURLs, pageControlView: pageControlView)
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
                activityViewController.excludedActivityTypes = [
                    .saveToCameraRoll,
                    .assignToContact,
                    .print
                ]
                self.present(activityViewController, animated: true, completion: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    @IBAction func closeButtonTouched(_ sender: Any) {
        guard !imagesPageViewController.pages.isEmpty else {
            self.dismiss(animated: true, completion: nil)
            return
        }

        if let presetImageViewController = imagesPageViewController.pages[0] as? PresetImageViewController {
            
            let imageView = presetImageViewController.imageView
            transitionDelegate = TransitionDelegate(to: origin, with: imageView)
            
            self.transitioningDelegate = transitionDelegate
            self.dismiss(animated: true, completion: nil)
        }
    }
}
