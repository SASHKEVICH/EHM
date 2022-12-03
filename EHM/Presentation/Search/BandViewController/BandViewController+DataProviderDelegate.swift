//
//  BandViewController+DataProviderDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 02.12.2022.
//

import Foundation

extension BandViewController: DataProviderDelegate {
    func didRecieve(data: Any) {
        if let band = data as? Band {
            self.albums = band.albums
            discographyCollectionView.reloadData()
            present(band: band)
        }
        
        view.setNeedsUpdateConstraints()
    }
}
