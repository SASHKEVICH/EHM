//
//  Band.swift
//  EHM
//
//  Created by Александр Бекренев on 12.11.2022.
//

import Foundation

struct Band: Decodable {
    let id: Int
    let title: String
    let origin: String?
    let founded: Date?
    let ended: Date?
    let country: String?
    let history: String?
    let albums: [Album]?
    let genres: [String?]?
    let currentMembers: [Member]?
    let previousMembers: [Member]?
    
    private enum CodingKeys: String, CodingKey {
        case origin = "origin_city"
        case id = "band_id"
        case title = "title"
        case founded = "founded"
        case ended = "ended"
        case country = "country"
        case history = "history"
        case albums = "albums"
        case genres = "genres"
        case currentMembers = "currentMembers"
        case previousMembers = "previousMembers"
    }
    
    func getYearsRepresentation() -> String {
        let years = "\(founded?.yearString ?? "") - \(ended?.yearString ?? "н.в.")"
        return years
    }
    
    func getGenres() -> String {
        guard let genres = genres else { return "" }
        let filtredGenres = genres.compactMap { $0 }
        return filtredGenres.joined(separator: ", ")
    }
}
