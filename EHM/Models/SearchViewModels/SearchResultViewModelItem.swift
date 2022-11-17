//
//  SearchViewModelItem.swift
//  EHM
//
//  Created by Александр Бекренев on 14.11.2022.
//

import Foundation

protocol SearchResultViewModelItem {
    var id: Int { get }
    var sectionTitle: String { get }
    var title: String { get }
    var type: SearchViewModelItemType { get }
}
