//
//  CircleImageView.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 19/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        setLayout()
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
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    func setImage(_ image: UIImage) {
        self.image = image
        setLayout()
    }
}
