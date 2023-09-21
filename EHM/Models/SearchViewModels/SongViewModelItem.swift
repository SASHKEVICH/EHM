//
//  SongViewModelItem.swift
//  EHM
//
//  Created by Александр Бекренев on 14.11.2022.
//

import UIKit

final class SongViewModelItem: SearchResultViewModelItem {
    var id: Int
    var albumId: Int
    var title: String
    var album: String
    var cover: UIImage?
    var duration: String?
    var explicit: Bool?

    var type: SearchViewModelItemType {
        return .song
    }

    var sectionTitle: String {
        return NSLocalizedString("Песни", comment: "")
    }

    init(id: Int, albumId: Int, title: String, album: String) {
        self.id = id
        self.albumId = albumId
        self.title = title
        self.album = album
    }

    convenience init(from model: Decodable) throws {
        guard let song = model as? Song, let album = song.album?.first else { throw ConstructError.song }
        self.init(id: song.songId, albumId: album.albumId, title: song.title, album: album.title)
    }
}
