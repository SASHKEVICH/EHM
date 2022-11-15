//
//  SearchViewController+SearchServiceDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 14.11.2022.
//

import Foundation

extension SearchViewController: SearchServiceDelegate {
    func didRecieveSearchResult(result: SearchResultViewModel) {
        searchResult = result
        searchTableView.reloadData()
    }
    
    func didFailToLoadData(error: Error) {
        
    }
}
