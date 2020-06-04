//
//  CDPreset+CoreDataProperties.swift
//  PresetsMarketplace
//
//  Created by Pedro Henrique Guedes Silveira on 04/06/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//
//

import Foundation
import CoreData


extension CDPreset {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPreset> {
        return NSFetchRequest<CDPreset>(entityName: "CDPreset")
    }

    @NSManaged public var isAcquired: Bool
    @NSManaged public var id: String?

}
