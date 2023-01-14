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
}
