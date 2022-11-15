//
//  SearchViewModelItem.swift
//  EHM
//
//  Created by Александр Бекренев on 14.11.2022.
//

import Foundation

protocol SearchResultViewModelItem {
    var type: SearchViewModelItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String { get }
    var title: String { get }
}

extension SearchResultViewModelItem {
    var rowCount: Int {
        return 1
    }
}
