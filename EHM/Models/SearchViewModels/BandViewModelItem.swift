//
//  BandViewModelItem.swift
//  EHM
//
//  Created by Александр Бекренев on 14.11.2022.
//

import Foundation

class BandViewModelItem: SearchResultViewModelItem {
    var title: String
    
    var type: SearchViewModelItemType {
        return .band
    }
    
    var sectionTitle: String {
        return NSLocalizedString("Группы", comment: "")
    }
    
    init(title: String) {
        self.title = title
    }
}
