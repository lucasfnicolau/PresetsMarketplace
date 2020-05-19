//
//  RoundedBluredView.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 19/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedBluredView: UIVisualEffectView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            setLayout()
        }
    }

    @IBInspectable var isFullyRounded: Bool = false {
        didSet {
            setLayout()
        }
    }

    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setLayout()
    }

    func setLayout() {
        self.layer.cornerRadius = isFullyRounded ? self.frame.height / 2 : cornerRadius
        self.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        super.init(effect: UIBlurEffect(style: .light))
    }

}
