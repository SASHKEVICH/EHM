//
//  AlbumViewController+DataProviderDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 17.11.2022.
//

import Foundation

extension AlbumViewController: DataProviderDelegate {
    func didRecieve(data: Any) {
        if let album = data as? AlbumViewModelItem {
            present(album: album)
        }
        
        if let songs = data as? [SongViewModelItem] {
            self.songs = songs
            songsTableView.reloadData()
        }
        
        view.setNeedsUpdateConstraints()
    }
}
