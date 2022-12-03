//
//  BandProvidedData.swift
//  EHM
//
//  Created by Александр Бекренев on 02.12.2022.
//

import Foundation

struct BandProvidedData: Decodable, ProvidedData {
    var message: String
    var info: Band
}
