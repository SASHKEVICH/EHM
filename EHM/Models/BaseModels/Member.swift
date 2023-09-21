//
//  Member.swift
//  EHM
//
//  Created by Александр Бекренев on 12.11.2022.
//

import Foundation

struct Member: Decodable {
    let memberId: Int
    let name: String
    let birthDate: Date?
    let dieDate: Date?
    let originCity: String?
    let biography: String?
    let photoPath: String?
    let currentBands: [Band]?

    func getYears() -> String {
        let years = "\(birthDate?.yearString ?? "") - \(dieDate?.yearString ?? "н.в.")"
        return years
    }
}
