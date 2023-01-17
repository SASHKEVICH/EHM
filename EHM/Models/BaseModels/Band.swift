//
//  Band.swift
//  EHM
//
//  Created by Александр Бекренев on 12.11.2022.
//

import Foundation

struct Band: Decodable {
    let bandId: Int
    let title: String
    let origin: String?
    let founded: Date?
    let ended: Date?
    let country: String?
    let history: String?
    let photoPath: String?
    let albums: [Album]?
    let genres: [Genre]?
    let members: [Member]?
    
    func getYears() -> String {
        let years = "\(founded?.yearString ?? "") - \(ended?.yearString ?? "н.в.")"
        return years
    }
    
    func getGenres() -> String {
        guard let genres = genres else { return "" }
        let filtredGenres = genres.compactMap { $0.name }
        return filtredGenres.joined(separator: ", ")
    }
    
    func getOrigin() -> String {
        guard let origin = origin, let country = country else { return "" }
        return "\(origin), \(country)"
    }
}
