//
//  URLManager.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 19/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import Foundation

class URLManager {
    class func getURLArray(from linksArray: [String]) -> [URL?] {
        return linksArray.map { URL(string: $0) }
    }
}
