//
//  MemberProvidedData.swift
//  EHM
//
//  Created by Александр Бекренев on 03.12.2022.
//

import Foundation

struct MemberProvidedData: Decodable, ProvidedData {
    var message: String
    var info: [Member]
}
