//
//  AlbumViewModel.swift
//  EHM
//
//  Created by Александр Бекренев on 14.11.2022.
//

import Foundation

class AlbumViewModelItem: SearchResultViewModelItem {
    var title: String
    var band: String
    var explicit: Bool
    
    var type: SearchViewModelItemType {
        return .album
    }
    
    var sectionTitle: String {
        return NSLocalizedString("Альбомы", comment: "")
    }
    
    init(title: String, band: String, explicit: Bool) {
        self.band = band
        self.title = title
        self.explicit = explicit
    }
}
