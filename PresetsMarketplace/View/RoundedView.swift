//
//  RoundedView.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 26/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setLayout()
    }

    func setLayout() {
        self.layer.cornerRadius = min(self.frame.width, self.frame.height) / 2
    }
}
