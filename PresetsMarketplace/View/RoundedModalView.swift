//
//  RoundedModalView.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 04/06/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

@IBDesignable class RoundedModalView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 20 {
        didSet {
            setLayout()
        }
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setLayout()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
    }

    func setLayout() {
        self.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        self.layer.cornerRadius = cornerRadius
    }
}
