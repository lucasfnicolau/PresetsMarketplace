//
//  DynamicCollectionViewCell.swift
//  PresetsMarketplace
//
//  Created by gabriel on 20/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class DynamicCollectionViewCell: UICollectionViewCell {
    
    let cellImageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentMode = .scaleAspectFill
        cellImageView.contentMode = .scaleAspectFill
        contentView.addSubview(cellImageView)
        setupCornerRadius()
        setupConstraints()
        cellImageView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(for preset: Preset) {
        preset.loadImagesData {
            DispatchQueue.main.async {
                self.cellImageView.image = UIImage(data: preset.imagesData[0])
            }
        }
    }
    
    func setupConstraints() {
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            cellImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            cellImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            cellImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
    }
    
    func setupCornerRadius() {
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 4
    }
    
    override func prepareForReuse() {
        cellImageView.image = nil
    }
    
    /// Prevent the cell from bug when the large title from the view shrinks with scroll
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        return layoutAttributes
    }
}
