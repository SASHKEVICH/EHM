//
//  Album.swift
//  EHM
//
//  Created by Александр Бекренев on 12.11.2022.
//

import Foundation

struct Album: Decodable {
    let albumId: Int
    let title: String
    let albumCoverPath: String?
    let released: Date?
    let explicit: Bool?
    let history: String?
    let type: String?
    let band: Band?
    let genres: [String?]?

    func getGenres() -> String {
        guard let genres = genres else { return "" }
        let filtredGenres = genres.compactMap { $0 }
        return filtredGenres.joined(separator: ", ")
    }
}
