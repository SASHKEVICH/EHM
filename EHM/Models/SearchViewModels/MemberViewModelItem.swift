//
//  MemberViewModelItem.swift
//  EHM
//
//  Created by Александр Бекренев on 04.12.2022.
//

import Foundation

class MemberViewModelItem: SearchResultViewModelItem {
    var id: Int
    var title: String
    
    var type: SearchViewModelItemType {
        return .member
    }
    
    var sectionTitle: String {
        return NSLocalizedString("Музыкант", comment: "")
    }
    
    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}
