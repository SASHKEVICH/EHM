//
//  SongViewModelItem.swift
//  EHM
//
//  Created by Александр Бекренев on 14.11.2022.
//

import Foundation

class SongViewModelItem: SearchResultViewModelItem {
    var id: Int
    var title: String
    var album: String
    
    var type: SearchViewModelItemType {
        return .song
    }
    
    var sectionTitle: String {
        return NSLocalizedString("Песни", comment: "")
    }
    
    init(id: Int, title: String, album: String) {
        self.id = id
        self.title = title
        self.album = album
    }
}
