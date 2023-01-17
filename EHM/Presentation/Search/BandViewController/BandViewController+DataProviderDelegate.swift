//
//  BandViewController+DataProviderDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 02.12.2022.
//

import Foundation

extension BandViewController: DataProviderDelegate {
    func didRecieve(item: SearchResultViewModelItem) {
        if let band = item as? BandViewModelItem {
            albums = band.albums
            currentMembers = band.members
            discographyCollectionView.reloadData()
            currentMembersTableView.reloadData()
            
            present(band: band)
        }
        
        view.setNeedsUpdateConstraints()
    }
    
    func didFailToLoadData(error: Error) {
        alertPresenter?.requestPresentAlert(for: error)
    }
}
