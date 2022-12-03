//
//  Member.swift
//  EHM
//
//  Created by Александр Бекренев on 12.11.2022.
//

import Foundation

struct Member: Decodable {
    let id: Int
    let name: String
    let birthDate: Date?
    let dieDate: Date?
    let origin: String?
    let biography: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case birthDate = "bdate"
        case dieDate = "ddate"
        case origin = "origin"
        case biography = "biography"
    }
}
