//
//  Song.swift
//  EHM
//
//  Created by Александр Бекренев on 12.11.2022.
//

import Foundation

struct Song: Decodable, BaseModelProtocol {
    let id: Int
    let duration: String?
    let title: String
    let album: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "song_id"
        case duration = "duration"
        case title = "title"
        case album = "album"
    }
}
