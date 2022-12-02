//
//  BandViewController+UICollectionViewDataSource.swift
//  EHM
//
//  Created by Александр Бекренев on 02.12.2022.
//

import Foundation
import UIKit

extension BandViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = albumsCollectionView.dequeueReusableCell(withReuseIdentifier: "AlbumsCollectionViewCell", for: indexPath)
        return cell
    }    
}
