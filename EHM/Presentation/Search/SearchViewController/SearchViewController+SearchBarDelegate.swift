//
//  SearchViewController+SearchBarDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 12.11.2022.
//

import UIKit

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchRequest = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        makeRequest()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
//        searchTableView.reloadData()
    }

    func makeRequest() {
        guard let request = searchRequest, request != "" else { return }
        searchService?.search(with: request)
    }
}
