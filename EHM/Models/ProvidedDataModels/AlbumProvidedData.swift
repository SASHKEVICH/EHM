//
//  AlbumProvidedData.swift
//  EHM
//
//  Created by Александр Бекренев on 17.11.2022.
//

import Foundation

struct AlbumProvidedData: Decodable, ProvidedData {
    var message: String
    var info: [Album]
}
