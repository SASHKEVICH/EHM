//
//  AlbumViewController+DataProviderDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 17.11.2022.
//

import Foundation

extension AlbumViewController: DataProviderDelegate {
    func didRecieve(data: Any) {
        if let album = data as? Album {
            present(album: album)
        }
        
        if let songs = data as? [Song] {
            self.songs = songs
            songsTableView.reloadData()
            songsTableView.invalidateIntrinsicContentSize()
        }
        
        contentView.invalidateIntrinsicContentSize()
        view.setNeedsUpdateConstraints()
    }
}
