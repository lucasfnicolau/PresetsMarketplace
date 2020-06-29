//
//  RoundedButton.swift
//  PresetsMarketplace
//
//  Created by Leonardo Oliveira on 04/06/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

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
