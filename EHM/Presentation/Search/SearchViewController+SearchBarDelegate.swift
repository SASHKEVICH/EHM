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
        view.endEditing(true)
        guard let request = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        if request != "" {
            searchService?.requestSearch(with: request)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.text = nil
        searchResult?.items.removeAll()
        searchTableView.reloadData()
    }
}
