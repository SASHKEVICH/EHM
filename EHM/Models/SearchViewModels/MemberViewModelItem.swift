//
//  MemberViewModelItem.swift
//  EHM
//
//  Created by Александр Бекренев on 04.12.2022.
//

import UIKit

final class MemberViewModelItem: SearchResultViewModelItem {
    var id: Int
    var title: String
    var years: String?
    var biography: String?
    var origin: String?
    var cover: UIImage?
    var currentBands: [BandViewModelItem]?

    var type: SearchViewModelItemType {
        return .member
    }

    var sectionTitle: String {
        return NSLocalizedString("Музыкант", comment: "")
    }

    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }

    init(from model: Decodable) throws {
        guard let member = model as? Member else { throw ConstructError.member }
        let imageLoader = ImageLoader()
        self.id = member.memberId
        self.title = member.name
        self.cover = imageLoader.load(from: member.photoPath)
        self.origin = member.originCity
        self.years = member.getYears()
        self.currentBands = member.currentBands?.map { band in
            let bandVM = BandViewModelItem(id: band.bandId, title: band.title)
            return bandVM
        }
    }
}
