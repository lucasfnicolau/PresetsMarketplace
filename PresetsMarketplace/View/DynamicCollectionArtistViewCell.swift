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
    let salesLabel: UILabel = UILabel()
    let viewsLabel: UILabel = UILabel()
    var isInitialized = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBlurredRect()
        setupSalesStackView()
        setupViewsStackView()
        setupImages()
        setupLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabelsValues(sales: Int, views: Int) {
        salesLabel.text = (sales / 1000 >= 1) ? "\(sales / 1000)k" : "\(sales)"
        viewsLabel.text = (views / 1000 >= 1) ? "\(views / 1000)k" : "\(views)"
    }
    
    func setup(for imageURL: URL?, views: Int, sales: Int) {
        self.setup(for: imageURL)
        self.views = views
        self.sales = sales
        setLabelsValues(sales: sales, views: views)
    }
    
    func setupBlurredRect() {
        self.contentView.addSubview(blurredRect)
        //        let cellWidth = self.frame.size.width * 0.42
        let cellWidth = self.frame.size.width * 0.5
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
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
    }
    
    func setupSalesStackView() {
        setupStackView(stackView: salesStackView)
        blurredRect.contentView.addSubview(salesStackView)
        
        salesStackView.translatesAutoresizingMaskIntoConstraints = false
        //        let width = blurredRect.frame.size.width * 0.4
        let width = (self.frame.size.width * 0.5) * 0.4
        NSLayoutConstraint.activate([
            salesStackView.topAnchor.constraint(equalTo: blurredRect.safeAreaLayoutGuide.topAnchor, constant: 3),
            salesStackView.bottomAnchor.constraint(equalTo: blurredRect.safeAreaLayoutGuide.bottomAnchor, constant: -3),
            salesStackView.leadingAnchor.constraint(equalTo: blurredRect.safeAreaLayoutGuide.leadingAnchor, constant: 6),
            salesStackView.widthAnchor.constraint(equalToConstant: width)
        ])
    }
    
    func setupViewsStackView() {
        setupStackView(stackView: viewsStackView)
        blurredRect.contentView.addSubview(viewsStackView)
        
        viewsStackView.translatesAutoresizingMaskIntoConstraints = false
        let width = (self.frame.size.width * 0.5) * 0.4
        NSLayoutConstraint.activate([
            viewsStackView.topAnchor.constraint(equalTo: blurredRect.safeAreaLayoutGuide.topAnchor, constant: 3),
            viewsStackView.bottomAnchor.constraint(equalTo: blurredRect.safeAreaLayoutGuide.bottomAnchor, constant: -3),
            viewsStackView.trailingAnchor.constraint(equalTo: blurredRect.safeAreaLayoutGuide.trailingAnchor, constant: -6),
            viewsStackView.widthAnchor.constraint(equalToConstant: width)
        ])
    }
    
    func setupLabels() {
        salesLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        salesImage.contentMode = .scaleAspectFit
        viewsImage.contentMode = .scaleAspectFit
        
        salesImage.translatesAutoresizingMaskIntoConstraints = false
        viewsImage.translatesAutoresizingMaskIntoConstraints = false
        
        let width = (self.frame.size.width * 0.5) * 0.4 * 0.3
        
        NSLayoutConstraint.activate([
            salesImage.widthAnchor.constraint(equalToConstant: width),
            viewsImage.widthAnchor.constraint(equalToConstant: width)
        ])
        
        salesStackView.addArrangedSubview(salesImage)
        viewsStackView.addArrangedSubview(viewsImage)
    }
}
