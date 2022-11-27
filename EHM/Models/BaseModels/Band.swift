//
//  Band.swift
//  EHM
//
//  Created by Александр Бекренев on 12.11.2022.
//

import Foundation

struct Band: Decodable, BaseModelProtocol {
    let id: Int
    let title: String
    let origin: String?
    let founded: String?
    let ended: String?
    let country: String?
    
    private enum CodingKeys: String, CodingKey {
        case origin = "origin_city"
        case id = "band_id"
        case title = "title"
        case founded = "founded"
        case ended = "ended"
        case country = "country"
    }
}
