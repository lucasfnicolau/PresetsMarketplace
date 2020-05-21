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
    var blurredRect: UIVisualEffectView = UIVisualEffectView()
    let salesStackView: UIStackView = UIStackView()
    let viewsStackView: UIStackView = UIStackView()
    
    func setup (image: UIImage, views: Int, sales: Int) {
        self.setup(image: image)
        self.views = views
        self.sales = sales
                
        setupBlurredRect()
        setupSalesStackView()
        setupViewsStackView()
//        setupImages()
//        setupLabels()
    }
    
    func setupBlurredRect() {
        self.contentView.addSubview(blurredRect)
        let cellWidth = self.frame.size.width * 0.42
        let cellHeight = cellWidth * 0.27
        
        let blurredEffect = UIBlurEffect(style: .light)
        blurredRect.effect = blurredEffect
        
        blurredRect.layer.masksToBounds = true
        blurredRect.layer.cornerRadius = 4
        blurredRect.layer.maskedCorners = [.layerMinXMinYCorner]
        blurredRect.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blurredRect.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            blurredRect.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blurredRect.widthAnchor.constraint(equalToConstant: cellWidth),
            blurredRect.heightAnchor.constraint(equalToConstant: cellHeight)
            
            ])
    }
    
    func setupStackView(stackView: UIStackView) {
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
    }
    
    func setupSalesStackView() {
        setupStackView(stackView: salesStackView)
        blurredRect.contentView.addSubview(salesStackView)
                
        salesStackView.translatesAutoresizingMaskIntoConstraints = false
//        let width = blurredRect.frame.size.width * 0.4
        let width = (self.frame.size.width * 0.42) * 0.4
        NSLayoutConstraint.activate([
            salesStackView.topAnchor.constraint(equalTo: blurredRect.safeAreaLayoutGuide.topAnchor, constant: 3),
            salesStackView.bottomAnchor.constraint(equalTo: blurredRect.safeAreaLayoutGuide.bottomAnchor, constant: 3),
            salesStackView.leadingAnchor.constraint(equalTo: blurredRect.safeAreaLayoutGuide.leadingAnchor, constant: 1),
            salesStackView.widthAnchor.constraint(equalToConstant: width)
        ])
    }
    
    func setupViewsStackView() {
        setupStackView(stackView: viewsStackView)
        blurredRect.contentView.addSubview(viewsStackView)
                
        viewsStackView.translatesAutoresizingMaskIntoConstraints = false
        let width = (self.frame.size.width * 0.42) * 0.4
        NSLayoutConstraint.activate([
            viewsStackView.topAnchor.constraint(equalTo: blurredRect.safeAreaLayoutGuide.topAnchor, constant: 3),
            viewsStackView.bottomAnchor.constraint(equalTo: blurredRect.safeAreaLayoutGuide.bottomAnchor, constant: 3),
            viewsStackView.trailingAnchor.constraint(equalTo: blurredRect.safeAreaLayoutGuide.trailingAnchor, constant: 1),
            viewsStackView.widthAnchor.constraint(equalToConstant: width)
        ])
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
        
        salesLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        let width = (self.frame.size.width * 0.42) * 0.2
//        
//        NSLayoutConstraint.activate([
//            salesLabel.widthAnchor.constraint(equalToConstant: width),
//            viewsLabel.widthAnchor.constraint(equalToConstant: width)
//        ])
        
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
