//
//  ItunesResults.swift
//  ITunesSearch
//
//  Created by William Moody on 5/16/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import Foundation

struct TopLevelJson: Codable {
    let results: [ITunesResults]
}


struct ITunesResults: Codable {
    
    let artist: String
    let track: String
    let album: String
    let imageURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case artist = "artistName"
        case track = "trackName"
        case album = "collectionName"
        case imageURL = "artworkUrl30"
    }
}


