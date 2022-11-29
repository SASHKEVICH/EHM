//
//  Album.swift
//  EHM
//
//  Created by Александр Бекренев on 12.11.2022.
//

import Foundation

struct Album: Decodable {
    let id: Int
    let title: String
    let cover: String?
    let released: String?
    let explicit: Bool
    let history: String?
    let type: String?
    let band: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "album_id"
        case title = "title"
        case cover = "cover"
        case released = "released"
        case explicit = "explicit"
        case history = "history"
        case type = "type"
        case band = "band"
    }
}
