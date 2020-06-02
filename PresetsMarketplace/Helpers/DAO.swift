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
    var user: User?

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
        user.setValue("", forKey: "about")
        user.setValue(0, forKey: "isArtist")

        cloudKitManager.save(record: user, on: .publicDB) { result in
            switch result {
            case .success(let record):
                print(record)
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }

    func getUser(withId id: String) {
        fetchRecord(usingRecordID: CKRecord.ID(recordName: id)) { record in
            guard let record = record else { return }
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

        // MARK:- TODO: Terminar de instanciar todas informações do User

        var acquiredPresetsReferences = [CKRecord.Reference]()
        if let guardedAcquiredPresetsReferences = record["acquiredPresets"] as? [CKRecord.Reference] {
            acquiredPresetsReferences = guardedAcquiredPresetsReferences
        }

        var followingArtists = [Artist]()
        var acquiredPresets = [Preset]()

        fetchRecords(usingRecordsID: followingArtistsReferences.map { $0.recordID }) { records in
            records.forEach { [weak self] in
                guard let self = self else { return }
                self.instantiateArtist(usingRecord: $0) { artist in
                    guard let artist = artist else { return }
                    followingArtists.append(artist)
                }
            }

            self.user = User(id: record.recordID.recordName,
                             name: name,
                             profileImageLink: profileImageLink,
                             following: followingArtists)
        }
    }

    private func instantiateArtist(usingRecord record: CKRecord, completion: @escaping (Artist?) -> Void) {
        guard let name = record["name"] as? String,
            let about = record["about"] as? String else {
                print("Error when instantiating an Artist")
                completion(nil)
                return
        }

        var profileImageLink = ""
        if let guardedProfileImage = record["profileImage"] as? CKAsset {
            profileImageLink = guardedProfileImage.fileURL?.absoluteString ?? ""
        }

        let artist = Artist(id: record.recordID.recordName,
                            name: name,
                            about: about,
                            profileImageLink: profileImageLink)

        if let presetsReference = record["presets"] as? [CKRecord.Reference] {
            fetchRecords(usingRecordsID: presetsReference.map { $0.recordID }) { records in
                records.forEach { [weak self] in
                    guard let self = self else { return }
                    self.instantiatePreset(usingRecord: $0) { preset in
                        guard let preset = preset else { return }
                        artist.addPreset(preset)
                    }
                }
                completion(artist)
            }
        } else {
            completion(artist)
        }
    }

    private func instantiatePreset(usingRecord record: CKRecord, completion: @escaping (Preset?) -> Void) {
        guard let name = record["name"] as? String,
            let description = record["description"] as? String,
            let price = record["price"] as? Double else {
                print("Error when instantiating a Preset")
                completion(nil)
                return
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

        if let artistReference = record["artist"] as? CKRecord.Reference {
            fetchRecord(usingRecordID: artistReference.recordID) { record in
                guard let record = record else { return }
                self.instantiateArtist(usingRecord: record) { artist in
                    guard let artist = artist else { return }
                    let preset = Preset(name: name,
                                        artist: artist,
                                        description: description,
                                        dngPath: dngPath,
                                        price: price,
                                        imagesLinks: imagesLinks)
                    completion(preset)
                }
            }
        }
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
}
