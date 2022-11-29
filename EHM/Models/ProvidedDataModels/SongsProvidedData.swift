//
//  SongsProvidedData.swift
//  EHM
//
//  Created by Александр Бекренев on 27.11.2022.
//

import Foundation

struct SongsProvidedData: Decodable, ProvidedData {
    var message: String
    var info: [Song]
}
