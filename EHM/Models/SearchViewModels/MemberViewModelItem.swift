//
//  MemberViewModelItem.swift
//  EHM
//
//  Created by Александр Бекренев on 04.12.2022.
//

import Foundation
import UIKit

class MemberViewModelItem: SearchResultViewModelItem {
    var id: Int
    var title: String
    var cover: UIImage?
    
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
