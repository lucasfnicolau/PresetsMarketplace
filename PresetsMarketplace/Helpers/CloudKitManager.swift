//
//  CloudKitManager.swift
//  PresetsMarketplace
//
//  Created by Pedro Henrique Guedes Silveira on 25/03/20.
//  Copyright © 2020 Pedro Henrique Guedes Silveira. All rights reserved.
//

import Foundation
import CloudKit

public class CloudKitManager {

    private let container: CKContainer
    private let publicDB: CKDatabase
    private let privateDB: CKDatabase

    private init() {
        container = CKContainer.default()
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
    }

    public static let shared = CloudKitManager()

    public func query(using Query: CKQuery, on database: Database, completionHandler: @escaping (Result<[CKRecord], CKError>) -> Void) {

        var db: CKDatabase?

        switch database {
        case .privateDB:
            db = privateDB
        case .publicDB:
            db = publicDB
        }

        if let db = db {
            db.perform(Query, inZoneWith: .default) { (records, error) in
                if let error = error as? CKError {
                    completionHandler(.failure(error))
                }
                guard let records = records else {return}
                completionHandler(.success(records))
            }
        }
    }

    public func save(record: CKRecord, on database: Database, completionHandler: @escaping (Result<CKRecord, CKError>) -> Void) {

        var db: CKDatabase?

        switch database {
        case .privateDB:
            db = privateDB
        case .publicDB:
            db = publicDB
        }

        if let db = db {
            db.save(record) { (_, error) in
                if let error = error as? CKError {
                    completionHandler(.failure(error))
                }
                completionHandler(.success(record))
            }
        }
    }

    public func update(recordID: CKRecord.ID, with newRecord: CKRecord, on database: Database, completionHandler: @escaping (Result<CKRecord, CKError>) -> Void) {

        var db: CKDatabase?

        switch database {
        case .privateDB:
            db = privateDB
        case .publicDB:
            db = publicDB
        }

        if let db = db {
            db.fetch(withRecordID: recordID) { (record, error) in
                if let error = error as? CKError {
                    completionHandler(.failure(error))
                }

                if let record = record {
                    let keys = newRecord.allKeys()
                    for key in keys {
                        record.setValue(newRecord.value(forKey: key), forKey: key)
                    }
                    db.save(record) { (updatedRecord, error) in
                        if let error = error as? CKError {
                            completionHandler(.failure(error))
                        }
                        if let updatedRecord = updatedRecord {
                            completionHandler(.success(updatedRecord))
                        }

                    }
                }
            }
        }
    }

    public func delete(recordID: CKRecord.ID, on database: Database, completionHandler: @escaping (Result<Void, CKError>) -> Void) {
        var db: CKDatabase?
        switch database {
        case .publicDB:
            db = publicDB
        case .privateDB:
            db = privateDB
        }
        if let db = db {
            db.delete(withRecordID: recordID) { (record, error) in
                if let error = error as? CKError {
                    completionHandler(.failure(error))
                }
                completionHandler(.success(Void()))
            }
        }
    }

    public func fetch(recordID: CKRecord.ID, on database: Database, completionHandler: @escaping ((Result<[CKRecord], CKError>) -> Void)) {

        var db: CKDatabase?
        switch database {
        case .publicDB:
            db = publicDB
        case .privateDB:
            db = privateDB
        }
        if let db = db {
            db.fetch(withRecordID: recordID) { (record, error) in
                if let error = error as? CKError {
                    completionHandler(.failure(error))
                }
                if let record = record {
                    var records = [CKRecord]()
                    records.append(record)
                    completionHandler(.success(records))
                }
            }
        }
    }

    public func fetchReferences(of recordIDs: [CKRecord.ID], on database: Database, completionHandler: @escaping ((Result<[CKRecord.Reference], CKError>) -> Void)) {

        var db: CKDatabase?
        switch database {
        case .publicDB:
            db = publicDB
        case .privateDB:
            db = privateDB
        }
        if let db = db {
            let fetchOperation = CKFetchRecordsOperation(recordIDs: recordIDs)
            fetchOperation.fetchRecordsCompletionBlock = { (recordsDict, error) in
                if let error = error as? CKError {
                    completionHandler(.failure(error))
                }
                if let recordsDict = recordsDict {
                    var records = [CKRecord]()
                    for (_, record) in recordsDict {
                        records.append(record)
                    }
                    var recordReferences: [CKRecord.Reference] = []
                    for record in records {
                        if let reference = record.parent {
                            recordReferences.append(reference)
                        }
                    }
                    completionHandler(.success(recordReferences))
                }
            }
            db.add(fetchOperation)
        }
    }

    public func generateQuery(of record: RecordType, with predicate: NSPredicate, sortedBy: NSSortDescriptor) -> CKQuery {
        let query = CKQuery(recordType: record.rawValue, predicate: predicate)
        query.sortDescriptors = [sortedBy]
        return query
    }
}
