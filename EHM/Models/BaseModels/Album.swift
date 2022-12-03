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
    let released: Date?
    let explicit: Bool?
    let history: String?
    let type: String?
    let band: String?
    let genres: [String?]?
    
    private enum CodingKeys: String, CodingKey {
        case id = "album_id"
        case title = "title"
        case cover = "cover"
        case released = "released"
        case explicit = "explicit"
        case history = "history"
        case type = "type"
        case band = "band"
        case genres = "genres"
    }
    
    func getGenres() -> String {
        guard let genres = genres else { return "" }
        let filtredGenres = genres.compactMap { $0 }
        return filtredGenres.joined(separator: ", ")
    }
}
