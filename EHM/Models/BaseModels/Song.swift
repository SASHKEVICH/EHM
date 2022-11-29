//
//  Song.swift
//  EHM
//
//  Created by Александр Бекренев on 12.11.2022.
//

import Foundation

struct Song: Decodable {
    let id: Int
    let duration: String?
    let explicit: Bool?
    let title: String
    let album: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "song_id"
        case duration = "duration"
        case explicit = "explicit"
        case title = "title"
        case album = "album"
    }
}
