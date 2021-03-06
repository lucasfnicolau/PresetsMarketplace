//
//  User.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 19/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import Foundation

class User: Equatable, Hashable {
    var id: String
    var name: String
    var profileImageUrl: URL?
    private(set) var following: [Artist]
    private(set) var acquiredPresets: [Preset]
    private(set) var publishedPresets: [Preset]

    init(id: String = UUID().uuidString,
         name: String,
         profileImageLink: String,
         following: [Artist] = [],
         acquiredPresets: [Preset] = [],
         publishedPresets: [Preset] = []) {
        self.id = id
        self.name = name
        self.profileImageUrl = URL(string: profileImageLink)
        self.following = following
        self.acquiredPresets = acquiredPresets
        self.publishedPresets = publishedPresets
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func startFollowing(artist: Artist) {
        self.following.append(artist)
    }
    
    public func stopFollowing(artist: Artist) {
        following.removeAll { $0 == artist }
    }
    
    func addPreset(_ preset: Preset) {
        acquiredPresets.append(preset)
    }
    
    func addPublishedPreset(_ preset: Preset) {
        publishedPresets.append(preset)
    }

    func hasPreset(_ preset: Preset) -> Bool {
        return acquiredPresets.contains(preset)
    }
    
    func resetAcquired() {
        self.acquiredPresets.removeAll()
    }
    
    func resetPublished() {
        self.publishedPresets.removeAll()
    }
}
