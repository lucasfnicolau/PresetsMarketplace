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
    @IBOutlet weak var modalView: RoundedModalView!

    @IBOutlet weak var modalViewTopConstraint: NSLayoutConstraint!

    enum CardViewState {
        case expanded
        case normal
    }

    var backingImage: UIImage?
    var cardViewState : CardViewState = .normal
    var cardPanStartingTopConstant : CGFloat = 30.0

    override func viewDidLoad() {
        super.viewDidLoad()
        backingImageView.image = backingImage

        if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            let safeAreaHeight = keyWindow.safeAreaLayoutGuide.layoutFrame.size.height
            let bottomPadding = keyWindow.safeAreaInsets.bottom
            modalViewTopConstraint.constant = safeAreaHeight + bottomPadding
        }

        blurView.alpha = 0.0

        let blurTap = UITapGestureRecognizer(target: self, action: #selector(blurViewTapped(_:)))
        blurView.contentView.addGestureRecognizer(blurTap)
        blurView.contentView.isUserInteractionEnabled = true

        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))

        viewPan.delaysTouchesBegan = false
        viewPan.delaysTouchesEnded = false

        self.view.addGestureRecognizer(viewPan)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showCard()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let presetInfoTableViewViewController = segue.destination as? PresetInfoTableViewViewController {
//            presetInfoTableViewViewController.preset = preset
//            presetInfoTableViewViewController.viewController = viewController
//            presetInfoTableViewViewController.blurView = blurView
//            presetInfoTableViewViewController.slideToMoreInfoStackView = slideToMoreInfoStackView
//        }
    }

    @objc func blurViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideCardAndGoBack()
    }

    @objc func viewPanned(_ panRecognizer: UIPanGestureRecognizer) {
        let translation = panRecognizer.translation(in: self.view)

        switch panRecognizer.state {
        case .began:
            cardPanStartingTopConstant = modalViewTopConstraint.constant
        case .changed :
            if self.cardPanStartingTopConstant + translation.y > 30.0 {
                self.modalViewTopConstraint.constant = self.cardPanStartingTopConstant + translation.y
            }
        case .ended :
            if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                let safeAreaHeight = keyWindow.safeAreaLayoutGuide.layoutFrame.size.height
                let bottomPadding = keyWindow.safeAreaInsets.bottom

                if self.modalViewTopConstraint.constant < (safeAreaHeight + bottomPadding) * 0.25 {
                    // show the card at expanded state
                    // we will modify showCard() function later
                } else if self.modalViewTopConstraint.constant < (safeAreaHeight) - 70 {
                    // show the card at normal state
                    showCard()
                } else {
                    // hide the card and dismiss current view controller
                    hideCardAndGoBack()
                }
            }
        default:
            break
        }
    }

    //MARK:- Animations
    private func showCard() {
        self.view.layoutIfNeeded()

        if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            let safeAreaHeight = keyWindow.safeAreaLayoutGuide.layoutFrame.size.height
            let bottomPadding = keyWindow.safeAreaInsets.bottom

            modalViewTopConstraint.constant = (safeAreaHeight + bottomPadding) / 2.0
        }

        let showCard = UIViewPropertyAnimator(duration: 0.2, curve: .easeIn, animations: {
            self.view.layoutIfNeeded()
        })

        showCard.addAnimations({
            self.blurView.alpha = 0.7
        })

        showCard.startAnimation()
    }

    private func hideCardAndGoBack() {
        self.view.layoutIfNeeded()

        if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            let safeAreaHeight = keyWindow.safeAreaLayoutGuide.layoutFrame.size.height
            let bottomPadding = keyWindow.safeAreaInsets.bottom

            modalViewTopConstraint.constant = safeAreaHeight + bottomPadding
        }

        let hideCard = UIViewPropertyAnimator(duration: 0.2, curve: .easeIn, animations: {
            self.view.layoutIfNeeded()
        })

        hideCard.addAnimations {
            self.blurView.alpha = 0.0
        }

        hideCard.addCompletion({ position in
            if position == .end {
                if(self.presentingViewController != nil) {
                    self.dismiss(animated: false, completion: nil)
                }
            }
        })

        hideCard.startAnimation()
    }
}
