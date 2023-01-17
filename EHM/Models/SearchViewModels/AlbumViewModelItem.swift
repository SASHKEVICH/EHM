//
//  AlbumViewModel.swift
//  EHM
//
//  Created by Александр Бекренев on 14.11.2022.
//

import UIKit

final class AlbumViewModelItem: SearchResultViewModelItem {
    var id: Int
    var title: String
    var band: String
    var explicit: Bool
    var cover: UIImage?
    var released: String?
    var history: String?
    var albumType: String?
    var genres: String?
    
    var type: SearchViewModelItemType {
        return .album
    }
    
    var sectionTitle: String {
        return NSLocalizedString("Альбомы", comment: "")
    }
    
    init(id: Int, title: String, band: String, explicit: Bool) {
        self.id = id
        self.band = band
        self.title = title
        self.explicit = explicit
    }
    
    init(from model: Decodable) throws {
        guard let album = model as? Album else { throw ConstructError.album }
        let imageLoader = ImageLoader()
        self.id = album.albumId
        self.title = album.title
        self.band = album.band?.first?.title ?? "some band"
        self.explicit = album.explicit ?? false
        self.cover = imageLoader.load(from: album.albumCoverPath)
        self.released = album.released?.dateString
        self.genres = album.getGenres()
        self.history = album.history
        self.albumType = album.type
    }
}
