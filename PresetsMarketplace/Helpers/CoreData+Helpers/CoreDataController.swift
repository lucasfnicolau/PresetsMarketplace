//
//  CoreDataController.swift
//  PresetsMarketplace
//
//  Created by Pedro Henrique Guedes Silveira on 04/06/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class CoreDataController: GenericDAO {

    typealias T = AcquiredPreset
    
    
    //    typealias T = VisitedPlaces
    
    let managedContext = CoreDataManager.shared.persistentContainer.viewContext
    private let entityName = "CDPreset"
    
    static let shared: CoreDataController = CoreDataController()
    
    public init() {
        
    }
    
    func create(newRecord: AcquiredPreset, of RecordType: CDRecordType) throws {
        
        let savedItems = try read(of: .AcquiredPreset)
        
        for savedItem in savedItems {
            if savedItem.identifier == newRecord.identifier {
                return
            }
        }
        
        guard let acquiredPresetEntity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) else {
            throw DAOError.internalError(description: "Failed to create NSEntityDescription Entity")
        }
        
        guard let acquiredPreset = NSManagedObject(entity: acquiredPresetEntity, insertInto: managedContext) as? CDPreset else {
            throw DAOError.internalError(description: "Failed to create NSManagedObject")
        }
        
        acquiredPreset.id = newRecord.identifier
        acquiredPreset.isAcquired = newRecord.isAcquired
        
        do {
            try managedContext.save()
        } catch {
            throw DAOError.internalError(description: "Problem to save Acquired Preset reference into managed context")
        }
        
        
    }
    
    func read(of RecordType: CDRecordType) throws -> [AcquiredPreset] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            guard let acquiredPresetData = result as? [CDPreset] else {
                throw DAOError.invalidData(description: "Failed to cast fetch request result to an Array of CDPreset")
            }
            
            var acquiredPresets:[AcquiredPreset] = []
            
            for data in acquiredPresetData {
                acquiredPresets.append(AcquiredPreset(identifier: data.id ?? "", isAcquired: data.isAcquired))
            }
            return acquiredPresets
        } catch {
            throw DAOError.internalError(description: "Problem during core  data fetch request")
        }
    }
}
