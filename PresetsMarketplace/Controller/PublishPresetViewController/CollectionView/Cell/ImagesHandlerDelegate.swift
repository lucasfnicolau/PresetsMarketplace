//
//  ImagesHandlerDelegate.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 04/06/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

protocol ImagesHandlerDelegate: class {
    func showImagePickerController()
    func removeImage(_ image: UIImage)
}
