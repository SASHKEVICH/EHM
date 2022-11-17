//
//  SearchViewController+SearchServiceDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 14.11.2022.
//

import Foundation
import UIKit

extension SearchViewController: SearchServiceDelegate {
    func didRecieveSearchResult(result: SearchResultViewModel) {
        searchResult = result
        searchTableView.reloadData()
    }
    
    func didFailToLoadData(error: Error) {
        let completion = computeCompletion(for: error)
        alertPresenter?.requestPresentAlert(title: "Что-то пошло не так",
                                            message: "\(error.localizedDescription)",
                                            buttonText: "Попробовать снова",
                                            completion: completion)
    }
    
    private func computeCompletion(for error: Error) -> (UIAlertAction) -> Void {
        let completion: (UIAlertAction) -> Void
        if let error = error as? SearchError, error == SearchError.foundNoData {
            completion = { _ in }
        } else {
            completion = { [weak self] _ in
                guard let self = self else { return }
                if let request = self.searchController.searchBar.text {
                    self.searchService?.requestSearch(with: request)
                }
            }
        }
        return completion
    }
}
