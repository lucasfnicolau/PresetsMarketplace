//
//  CoreData+Helpers.swift
//  PresetsMarketplace
//
//  Created by Pedro Henrique Guedes Silveira on 04/06/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import Foundation

public enum CDRecordType {
    case AcquiredPreset 
}

enum DAOError: Error {
    case invalidData(description: String)
    case internalError(description: String)
}

protocol GenericDAO {
    associatedtype T
    
    func create(newRecord: T, of RecordType: CDRecordType) throws
    func read(of RecordType: CDRecordType) throws -> [T]
}

struct AcquiredPreset: Codable, Equatable {
    let identifier: String
    let isAcquired: Bool   
}
