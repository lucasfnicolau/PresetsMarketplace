//
//  NotificationName.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 03/06/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import Foundation

enum NotificationName {
    static let userCreated: NSNotification.Name = NSNotification.Name("userCreated")
    static let feedDataFetched: NSNotification.Name = NSNotification.Name("feedDataFetched")
    static let discoverDataFetched: NSNotification.Name = NSNotification.Name("discoverDataFetched")
    static let profileDataFetched: NSNotification.Name = NSNotification.Name("profileDataFetched")
}
