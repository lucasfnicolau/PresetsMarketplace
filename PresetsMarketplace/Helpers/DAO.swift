//
//  DAO.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 01/06/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import Foundation
import CloudKit
import AuthenticationServices

class DAO: NSObject {
    private let cloudKitManager: CloudKitManager
    private(set) var user: User?
    private(set) var presets: [Preset] = []
    private(set) var userRecord: CKRecord?
    private var isLoading = false
    
    var isLoggedIn = false
    

    static let shared = DAO()

    private override init() {
        cloudKitManager = CloudKitManager()
    }

    func registerUser(withCredential credential: ASAuthorizationAppleIDCredential) {
        let name = credential.fullName?.givenName ?? UIDevice.current.name
        let email = credential.email ?? ""
        let id = credential.user

        let user = CKRecord(recordType: RecordType.user.rawValue, recordID: CKRecord.ID(recordName: id))
        user.setValue(name, forKey: "name")
        user.setValue(email, forKey: "email")
        user.setValue("Fotógrafo se aventurando na criação de presets.", forKey: "about")
        user.setValue(0, forKey: "isArtist")

        cloudKitManager.save(record: user, on: .publicDB) { result in
            switch result {
            case .success(let record):
                print(record)
                self.instantiateUser(usingRecord: record)
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }

    func getUser(withId id: String) {
        fetchRecord(usingRecordID: CKRecord.ID(recordName: id)) { [weak self] record in
            guard let self = self, let record = record else {
                KeychainItem.deleteUserIdentifierFromKeychain()
                return
            }
            self.userRecord = record
            self.instantiateUser(usingRecord: record)
        }
    }

    private func instantiateUser(usingRecord record: CKRecord) {
        guard let name = record["name"] as? String,
            let _ = record["email"] as? String else {
                print("Error when instantiating a User")
                return
        }

        var followingArtistsReferences = [CKRecord.Reference]()
        if let guardedFollowingArtistsReferences = record["followingArtists"] as? [CKRecord.Reference] {
            followingArtistsReferences = guardedFollowingArtistsReferences
        }

        var profileImageLink = ""
        if let guardedProfileImage = record["profileImage"] as? CKAsset {
            profileImageLink = guardedProfileImage.fileURL?.absoluteString ?? ""
        }

        var followingArtists = [Artist]()
        var presetsReferencesForFollowingArtists = [CKRecord.Reference]()

        fetchRecords(usingRecordsID: followingArtistsReferences.map { $0.recordID }) { records in
            records.forEach { [weak self] in
                guard let self = self,
                    let artist = self.instantiateArtist(usingRecord: $0) else { return }

                if let presets = $0["presets"] as? [CKRecord.Reference] {
                    presetsReferencesForFollowingArtists = presets
                }

                self.getPresetsReferencesForFollowingArtists(usingReferences: presetsReferencesForFollowingArtists) { records in
                    for index in records.indices {
                        guard let preset = self.instantiatePreset(usingRecord: records[index], andArtist: followingArtists[index]) else { return }
                        followingArtists[index].presets.append(preset)
                        NotificationCenter.default.post(name: NotificationName.feedDataFetched, object: nil, userInfo: ["item": index])
                    }
                }

                followingArtists.append(artist)
            }

            self.user = User(id: record.recordID.recordName,
                             name: name,
                             profileImageLink: profileImageLink,
                             following: followingArtists)
            
            self.isLoggedIn = true
            NotificationCenter.default.post(name: NotificationName.userCreated, object: nil)
        }
    }

    private func instantiateArtist(usingRecord record: CKRecord) -> Artist? {
        guard let name = record["name"] as? String,
            let about = record["about"] as? String else {
                print("Error when instantiating an Artist")
                return nil
        }

        var profileImageLink = ""
        if let guardedProfileImage = record["profileImage"] as? CKAsset {
            profileImageLink = guardedProfileImage.fileURL?.absoluteString ?? ""
        }

        let artist = Artist(id: record.recordID.recordName,
                            name: name,
                            about: about,
                            profileImageLink: profileImageLink)

        return artist
    }

    func loadAcquiredPresets() {
        guard let userRecord = userRecord else { return }

        if let acquiredPresetsReferences = userRecord["acquiredPresets"] as? [CKRecord.Reference] {
            
            user?.resetAcquired()

            fetchRecords(usingRecordsID: acquiredPresetsReferences.map { $0.recordID }) { [weak self] records in
                guard let self = self else { return }

                records.forEach {
                    guard let artistReference = $0["artist"] as? CKRecord.Reference else { return }
                    self.createPreset(usingRecord: $0, withArtistReference: artistReference) { preset in
                        guard let preset = preset else { return }
                        self.user?.addPreset(preset)
                        NotificationCenter.default.post(name: NotificationName.profileDataFetched, object: nil)
                    }
                }
            }
        } else {
            NotificationCenter.default.post(name: NotificationName.profileDataFetched, object: nil)
        }
    }
    
//    func loadPublishedPresets() {
//        guard let userRecord = userRecord else { return }
//
//        if let acquiredPresetsReferences = userRecord["presets"] as? [CKRecord.Reference] {
//
//            user?.resetPublished()
//
//            fetchRecords(usingRecordsID: acquiredPresetsReferences.map { $0.recordID }) { [weak self] records in
//                guard let self = self else { return }
//
//                records.forEach {
//                    guard let artistReference = $0["artist"] as? CKRecord.Reference else { return }
//                    self.createPreset(usingRecord: $0, withArtistReference: artistReference) { preset in
//                        guard let preset = preset else { return }
//                        self.user?.addPreset(preset)
//                        NotificationCenter.default.post(name: NotificationName.profileDataFetched, object: nil)
//                    }
//                }
//            }
//        }
//    }

    private func getPresetsReferencesForFollowingArtists(usingReferences references: [CKRecord.Reference], completion: @escaping ([CKRecord]) -> Void) {

        let ids = references.map { $0.recordID }
        fetchRecords(usingRecordsID: ids) { records in
            completion(records)
        }
    }

    private func instantiatePreset(usingRecord record: CKRecord, andArtist artist: Artist) -> Preset? {
        guard let name = record["name"] as? String,
            let description = record["description"] as? String,
            let price = record["price"] as? Double else {
                print("Error when instantiating a Preset")
                return nil
        }

        var dngPath = ""
        if let dng = record["dng"] as? CKAsset {
            dngPath = dng.fileURL?.absoluteString ?? ""
        }

        var imagesLinks = [String]()
        if let images = record["images"] as? [CKAsset] {
            images.forEach {
                imagesLinks.append($0.fileURL?.absoluteString ?? "")
            }
        }

        let preset = Preset(id: record.recordID.recordName,
                            name: name,
                            artist: artist,
                            description: description,
                            dngPath: dngPath,
                            price: price,
                            imagesLinks: imagesLinks)

        return preset
    }

    private func fetchRecord(usingRecordID recordID: CKRecord.ID, completion: @escaping (CKRecord?) -> Void) {
        cloudKitManager.fetch(recordID: recordID, on: .publicDB) { result in
            switch result {
            case .success(let records):
                if !records.isEmpty {
                    completion(records[0])
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
                break
            }
        }
    }

    private func fetchRecords(usingRecordsID recordsID: [CKRecord.ID], completion: @escaping ([CKRecord]) -> Void) {

        cloudKitManager.fetchRecords(of: recordsID, on: .publicDB) { result in
            switch result {
            case .success(let records):
                completion(records)
                break
            case .failure(let error):
                print(error.localizedDescription)
                completion([])
                break
            }
        }
    }

    func acquirePreset(_ preset: Preset) {
        guard let userRecord = userRecord else { return }

        let id = CKRecord.ID(recordName: preset.id)
        let presetReference = CKRecord.Reference(recordID: id, action: .none)

        var acquiredPresets = [CKRecord.Reference]()
        if let guardedAcquiredPresets = userRecord["acquiredPresets"] as? [CKRecord.Reference] {
            acquiredPresets.append(contentsOf: guardedAcquiredPresets)
        }
        acquiredPresets.append(presetReference)

        userRecord["acquiredPresets"] = acquiredPresets

        cloudKitManager.update(recordID: userRecord.recordID, with: userRecord, on: .publicDB) { result in
            switch result {
            case .success(let record):
                print(record)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }

    func publishPreset(_ preset: Preset, completion: @escaping (Bool) -> Void) {
        let presetRecord = CKRecord(recordType: RecordType.preset.rawValue)
        presetRecord["name"] = preset.name
        presetRecord["description"] = preset.description
        let id = CKRecord.ID(recordName: preset.artist.id)
        presetRecord["artist"] = CKRecord.Reference(recordID: id, action: .deleteSelf)
        presetRecord["price"] = preset.price

        if let dngURL = URL(string: preset.dngPath) {
            let dngAsset = CKAsset(fileURL: dngURL)
            presetRecord["dng"] = dngAsset
        }

        var imagesAssets = [CKAsset]()
        preset.imagesURLs.forEach {
            guard let url = $0 else { return }
            imagesAssets.append(CKAsset(fileURL: url))
        }
        presetRecord["images"] = imagesAssets

        cloudKitManager.save(record: presetRecord, on: .publicDB) { result in
            switch result {
            case .success(let record):
                completion(true)
                break
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
                break
            }
        }
    }
}

// MARK:- DiscoverViewController DAO
extension DAO {
    func loadAllPresets() {
        if isLoading { return }
        isLoading = true
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RecordType.preset.rawValue, predicate: predicate)

        cloudKitManager.query(using: query, on: .publicDB) { [weak self] result in
            switch result {
            case .success(let records):
                guard let self = self else { return }
                
                self.presets.removeAll()
                
                for index in records.indices {
                    if let artistReference = records[index]["artist"] as? CKRecord.Reference {
                        self.createPreset(usingRecord: records[index], withArtistReference: artistReference) { preset in
                            guard let preset = preset else { return }
                            self.presets.append(preset)
                            if self.presets.count == records.count {
                                self.isLoading = false
                            }
                            
                            NotificationCenter.default.post(name: NotificationName.discoverDataFetched, object: nil, userInfo: nil)
                        }
                    }
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }

    private func createPreset(usingRecord record: CKRecord, withArtistReference reference: CKRecord.Reference) {
        self.cloudKitManager.fetch(recordID: reference.recordID, on: .publicDB) { [weak self] result in
            switch result {
            case .success(let artistsRecords):
                if !artistsRecords.isEmpty {
                    guard let self = self,
                        let artist = self.instantiateArtist(usingRecord: artistsRecords[0]),
                        let preset = self.instantiatePreset(usingRecord: record, andArtist: artist) else { return }

                    self.presets.append(preset)
                    NotificationCenter.default.post(name: NotificationName.discoverDataFetched, object: nil, userInfo: nil)
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }

    private func createPreset(usingRecord record: CKRecord, withArtistReference reference: CKRecord.Reference, completion: @escaping (Preset?) -> Void) {

        self.cloudKitManager.fetch(recordID: reference.recordID, on: .publicDB) { [weak self] result in
            switch result {
            case .success(let artistsRecords):
                if !artistsRecords.isEmpty {
                    guard let self = self,
                        let artist = self.instantiateArtist(usingRecord: artistsRecords[0]),
                        let preset = self.instantiatePreset(usingRecord: record, andArtist: artist) else { return }
                    completion(preset)
                }
                break
            case .failure(let error):
                completion(nil)
                print(error.localizedDescription)
                break
            }
        }
    }

    func startFollowing(artist: Artist) {
        guard let userRecord = userRecord else { return }

        var followingArtistsReferences = [CKRecord.Reference]()
        if let guardedFollowingArtistsReferences = userRecord["followingArtists"] as? [CKRecord.Reference] {
            followingArtistsReferences = guardedFollowingArtistsReferences
        }

        let artistReference = CKRecord.Reference(recordID: CKRecord.ID(recordName: artist.id), action: .none)

        if !followingArtistsReferences.contains(artistReference) {
            followingArtistsReferences.append(artistReference)
            self.user?.startFollowing(artist: artist)
        } else {
            return
        }

        userRecord["followingArtists"] = followingArtistsReferences
        cloudKitManager.save(record: userRecord, on: .publicDB) { result in
            switch result {
            case .success(_):
                NotificationCenter.default.post(name: NotificationName.feedDataFetched, object: nil)
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }

    func stopFollowing(artist: Artist) {
        guard let userRecord = userRecord else { return }

        var followingArtistsReferences = [CKRecord.Reference]()
        if let guardedFollowingArtistsReferences = userRecord["followingArtists"] as? [CKRecord.Reference] {
            followingArtistsReferences = guardedFollowingArtistsReferences
        }

        let artistReference = CKRecord.Reference(recordID: CKRecord.ID(recordName: artist.id), action: .none)

        if followingArtistsReferences.contains(artistReference) {
            followingArtistsReferences.removeAll(where: { $0 == artistReference })
            self.user?.stopFollowing(artist: artist)
        } else {
            return
        }

        userRecord["followingArtists"] = followingArtistsReferences
        cloudKitManager.save(record: userRecord, on: .publicDB) { result in
            switch result {
            case .success(_):
                NotificationCenter.default.post(name: NotificationName.feedDataFetched, object: nil)
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
}
