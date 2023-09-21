//
//  BandViewController+UICollectionViewDataSource.swift
//  EHM
//
//  Created by Александр Бекренев on 02.12.2022.
//

import UIKit

extension BandViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums?.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let albums = albums else { return UICollectionViewCell() }
        let cell = discographyCollectionView.dequeueReusableCell(
            withReuseIdentifier: "AlbumsCollectionViewCell",
            for: indexPath
        ) as? AlbumsCollectionViewCell
        let album = albums[indexPath.item]
        cell?.set(cover: album.cover, title: album.title)
        return cell ?? UICollectionViewCell()
    }
}
