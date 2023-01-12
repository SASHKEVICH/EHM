//
//  SearchResult.swift
//  EHM
//
//  Created by Александр Бекренев on 13.11.2022.
//

import Foundation

struct SearchResult: Decodable {
    let albums: [Album]
    let bands: [Band]
    let songs: [Song]
    let members: [Member]
}
