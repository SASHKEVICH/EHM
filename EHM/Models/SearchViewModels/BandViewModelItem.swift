//
//  BandViewModelItem.swift
//  EHM
//
//  Created by Александр Бекренев on 14.11.2022.
//

import Foundation

class BandViewModelItem: SearchResultViewModelItem {
    var id: Int
    var title: String
    
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
