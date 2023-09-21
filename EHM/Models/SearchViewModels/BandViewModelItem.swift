//
//  BandViewModelItem.swift
//  EHM
//
//  Created by Александр Бекренев on 14.11.2022.
//

import UIKit

final class BandViewModelItem: SearchResultViewModelItem {
    var id: Int
    var title: String
    var cover: UIImage?
    var origin: String?
    var years: String?
    var history: String?
    var genres: String?
    var albums: [AlbumViewModelItem]?
    var members: [MemberViewModelItem]?

    var type: SearchViewModelItemType {
        return .band
    }

    var sectionTitle: String {
        return NSLocalizedString("Группы", comment: "")
    }

    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }

    init(from model: Decodable) throws {
        guard let band = model as? Band else { throw ConstructError.band }
        let imageLoader = ImageLoader()
        self.id = band.bandId
        self.title = band.title
        self.cover = imageLoader.load(from: band.photoPath)
        self.origin = band.getOrigin()
        self.years = band.getYears()
        self.genres = band.getGenres()
        self.albums = band.albums?.map { album in
            let albumVM = AlbumViewModelItem(
                id: album.albumId,
                title: album.title,
                band: album.band?.first?.title ?? "some band",
                explicit: album.explicit ?? false
            )
            albumVM.cover = imageLoader.load(from: album.albumCoverPath)
            return albumVM
        }

        self.members = band.members?.map { member in
            let memberVM = MemberViewModelItem(id: member.memberId, title: member.name)
            return memberVM
        }
    }
}
