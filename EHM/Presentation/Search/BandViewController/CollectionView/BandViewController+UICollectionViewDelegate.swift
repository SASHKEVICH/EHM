//
//  BandViewController+UICollectionViewDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 03.12.2022.
//

import UIKit

extension BandViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let albums = albums else { return }
        let album = albums[indexPath.item]
        let albumVC = AlbumViewController(albumId: album.id, title: album.title)
        navigationController?.pushViewController(albumVC, animated: true)
    }
}
