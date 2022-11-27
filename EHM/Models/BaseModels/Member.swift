//
//  Member.swift
//  EHM
//
//  Created by Александр Бекренев on 12.11.2022.
//

import Foundation

struct Member: Decodable, BaseModelProtocol {
    let id: Int
    let name: String
    let birthDate: Date
    let dieDate: Date?
    let origin: String
    let bio: String
}
