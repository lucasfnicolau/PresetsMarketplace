//
//  DynamicCollectionArtistViewCell.swift
//  PresetsMarketplace
//
//  Created by gabriel on 20/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class DynamicColletionArtistViewCell: DynamicCollectionViewCell {
    
    var views: Int = 0
    var sales: Int = 0
    var blurredRect: UIView?
    let salesStackView: UIStackView = UIStackView()
    let viewsStackView: UIStackView = UIStackView()
    
    func setup (image: UIImage, views: Int, sales: Int) {
        self.setup(image: image)
        self.views = views
        self.sales = sales
        
        setupBlurredRect()
        setupSalesStackView()
        setupViewsStackView()
        setupImages()
        setupLabels()
    }
    
    func setupBlurredRect() {
        guard let blurredRect = blurredRect else { return }
        let cellWidth = self.frame.size.width * 0.42
        let cellHeight = blurredRect.frame.size.width * 0.27
        
        blurredRect.layer.cornerRadius = 4
        blurredRect.layer.maskedCorners = [.layerMinXMaxYCorner]
        blurredRect.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blurredRect.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            blurredRect.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            blurredRect.heightAnchor.constraint(equalToConstant: cellHeight),
            blurredRect.widthAnchor.constraint(equalToConstant: cellWidth)
            ])
        
        self.contentView.addSubview(blurredRect)
    }
    
    func setupStackView(stackView: UIStackView) {
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
    }
    
    func setupSalesStackView() {
        setupStackView(stackView: salesStackView)
        
        guard let blurredRect = blurredRect else { return }
        
        salesStackView.translatesAutoresizingMaskIntoConstraints = false
        let width = blurredRect.frame.size.width * 0.4
        NSLayoutConstraint.activate([
            salesStackView.topAnchor.constraint(equalTo: blurredRect.topAnchor, constant: 3),
            salesStackView.bottomAnchor.constraint(equalTo: blurredRect.bottomAnchor, constant: 3),
            salesStackView.leadingAnchor.constraint(equalTo: blurredRect.leadingAnchor, constant: 6),
            salesStackView.widthAnchor.constraint(equalToConstant: width)
        ])
        
        blurredRect.addSubview(salesStackView)
    }
    
    func setupViewsStackView() {
        setupStackView(stackView: viewsStackView)
        
        guard let blurredRect = blurredRect else { return }
        
        viewsStackView.translatesAutoresizingMaskIntoConstraints = false
        let width = blurredRect.frame.size.width * 0.4
        NSLayoutConstraint.activate([
            viewsStackView.topAnchor.constraint(equalTo: blurredRect.topAnchor, constant: 3),
            viewsStackView.bottomAnchor.constraint(equalTo: blurredRect.bottomAnchor, constant: 3),
            viewsStackView.trailingAnchor.constraint(equalTo: blurredRect.trailingAnchor, constant: 6),
            viewsStackView.widthAnchor.constraint(equalToConstant: width)
        ])
        
        blurredRect.addSubview(viewsStackView)
    }
    
    func setupLabels() {
        
        let salesLabel = UILabel()
        salesLabel.text = "\(sales)"
        
        let viewsLabel = UILabel()
        viewsLabel.text = "\(views)"
        
        if sales % 1000 >= 1 {
            salesLabel.text = "\(sales / 1000)k"
        }
        if views % 1000 >= 1 {
            viewsLabel.text = "\(views / 1000)k"
        }
        
        salesLabel.adjustsFontSizeToFitWidth = true
        viewsLabel.adjustsFontSizeToFitWidth = true
        
        salesStackView.addArrangedSubview(salesLabel)
        viewsStackView.addArrangedSubview(viewsLabel)
        
    }
    
    func setupImages() {
        let salesImage = UIImageView()
        salesImage.image = #imageLiteral(resourceName: "sales")
        
        let viewsImage = UIImageView()
        viewsImage.image = #imageLiteral(resourceName: "views")
        
        salesStackView.addArrangedSubview(salesImage)
        viewsStackView.addArrangedSubview(viewsImage)
    }
}
