//
//  Song.swift
//  EHM
//
//  Created by Александр Бекренев on 12.11.2022.
//

import Foundation

struct Song: Decodable {
    let songId: Int
    let duration: String?
    let explicit: Bool?
    let title: String
    let album: [Album]?
}
