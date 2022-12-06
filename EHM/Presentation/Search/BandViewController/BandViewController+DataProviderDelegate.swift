//
//  BandViewController+DataProviderDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 02.12.2022.
//

import Foundation

extension BandViewController: DataProviderDelegate {
    func didRecieve(data: Any) {
        if let band = data as? BandViewModelItem {
            albums = band.albums
//            currentMembers = band.currentMembers
//            previousMembers = band.previousMembers
            discographyCollectionView.reloadData()
            currentMembersTableView.reloadData()
            previousMembersTableView.reloadData()
            
            present(band: band)
        }
        
        view.setNeedsUpdateConstraints()
    }
}
