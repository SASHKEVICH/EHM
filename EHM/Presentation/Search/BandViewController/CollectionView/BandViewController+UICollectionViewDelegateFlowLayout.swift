//
//  BandViewController+UICollectionViewDelegateFlowLayout.swift
//  EHM
//
//  Created by Александр Бекренев on 02.12.2022.
//

import UIKit

extension BandViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 177)
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionInsets = UIEdgeInsets(
            top: 0.0,
            left: 23.0,
            bottom: 0.0,
            right: 20.0)
        return sectionInsets
    }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 20.0
  }
}
