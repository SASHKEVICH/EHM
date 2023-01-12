//
//  BandViewModelItem.swift
//  EHM
//
//  Created by Александр Бекренев on 14.11.2022.
//

import UIKit

class BandViewModelItem: SearchResultViewModelItem {
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
}
