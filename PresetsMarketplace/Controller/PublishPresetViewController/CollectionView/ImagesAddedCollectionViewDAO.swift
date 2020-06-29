//
//  ImagesAddedCollectionViewDAO.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 04/06/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class ImagesAddedCollectionViewDAO: NSObject {
    var images: NSMutableArray
    var imagesLinks: NSMutableArray = []

    init(with images: NSMutableArray = []) {
        self.images = images
    }
}
