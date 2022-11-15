//
//  SongViewModelItem.swift
//  EHM
//
//  Created by Александр Бекренев on 14.11.2022.
//

import Foundation

class SongViewModelItem: SearchResultViewModelItem {
    var title: String
    var album: String
    
    var type: SearchViewModelItemType {
        return .song
    }
    
    var sectionTitle: String {
        return NSLocalizedString("Песни", comment: "")
    }
    
    init(title: String, album: String) {
        self.title = title
        self.album = album
    }
}
