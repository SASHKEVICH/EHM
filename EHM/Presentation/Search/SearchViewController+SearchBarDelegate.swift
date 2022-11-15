//
//  SearchViewController+SearchBarDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 12.11.2022.
//

import Foundation
import UIKit

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let request = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        if request != "" {
            searchService?.requestSearch(with: request)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchResult?.items.removeAll()
        searchTableView.reloadData()
    }
}
