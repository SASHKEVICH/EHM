//
//  AlbumViewController+DataProviderDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 17.11.2022.
//

import Foundation

extension AlbumViewController: DataProviderDelegate {
    func didRecieve(data: BaseModelProtocol) {
        guard let album = data as? Album else {
            // Present some error
            return
        }
        
//        self.album = album
        present(album: album)
    }
}
