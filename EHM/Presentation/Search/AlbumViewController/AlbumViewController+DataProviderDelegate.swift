//
//  AlbumViewController+DataProviderDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 17.11.2022.
//

import Foundation

extension AlbumViewController: DataProviderDelegate {
    func didRecieve(item: SearchResultViewModelItem) {
        if let album = item as? AlbumViewModelItem {
            self.songs = album.songs
            songsTableView.reloadData()
            present(album: album)
        }
        
        view.setNeedsUpdateConstraints()
    }
    
    func didFailToLoadData(error: Error) {
        alertPresenter?.requestPresentAlert(for: error)
    }
}
