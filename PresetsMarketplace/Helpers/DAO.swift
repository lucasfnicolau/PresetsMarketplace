//
//  DAO.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 01/06/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import Foundation
import CloudKit

class DAO: NSObject {
    private let cloudKitManager: CloudKitManager
    var user: User?

    static let shared = DAO()

    private override init() {
        cloudKitManager = CloudKitManager()
    }

    func getUser(withId id: String) {
        cloudKitManager.fetch(recordID: CKRecord.ID(recordName: id), on: .publicDB) { result in
            switch result {
            case .success(let records):
                if !records.isEmpty {
                    self.instantiateUser(usingRecord: records[0])
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }

    private func getPresets() -> [Preset]? {
        return []
    }

    private func getPresets(forUser user: User) -> [Preset]? {
//        let recordId = CKRecord.ID(recordName: user.id)
//        cloudKitManager.fetch(recordID: user.id, on: .publicDB) { result in
//            <#code#>
//        }

        return []
    }

    private func instantiateUser(usingRecord record: CKRecord) {
        guard let id = record["id"] as? String,
            let name = record["name"] as? String,
            /* let profileImage = record["profileImage"] as? CKAsset, */
            let followingArtistsReferences = record["followingArtists"] as? [CKRecord.Reference]
            /* let acquiredPresetsReferences = record["acquiredPresets"] as? [CKRecord.Reference] */ else {
                print(record)
                return
        }

        var followingArtists = [Artist]()
        cloudKitManager.fetchRecords(of: followingArtistsReferences.map { $0.recordID }, on: .publicDB) { result in
            switch result {
            case .success(let records):
                records.forEach {
                    if let artist = self.instantiateArtist(usingRecord: $0) {
                        followingArtists.append(artist)
                    }
                }
                self.user = User(id: id,
                            name: name,
                            profileImageLink: "",
                            following: followingArtists)
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }

    private func instantiateArtist(usingRecord record: CKRecord) -> Artist? {
        guard let id = record["id"] as? String,
            let name = record["name"] as? String,
            let about = record["about"] as? String
            /* let profileImage = record["profileImage"] as? CKAsset */ else {
                return nil
        }

        let artist = Artist(id: id, name: name, about: about, profileImageLink: "")

        return artist
    }
}
