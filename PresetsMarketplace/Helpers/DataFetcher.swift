//
//  DataFetcher.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 03/06/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import Foundation

protocol DataFetcher: class {
    func dataFetched(_ notif: Notification)
}
