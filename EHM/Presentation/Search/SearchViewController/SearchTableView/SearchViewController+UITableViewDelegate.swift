//
//  SearchViewController+UITableViewDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 15.11.2022.
//

import Foundation
import UIKit

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = searchResult?.items[indexPath.item] else {
            fatalError("something went wrong in cells...")
        }

        switch item.type {
        case .album:
            let albumVC = AlbumViewController(albumId: item.id, title: item.title)
            navigationController?.pushViewController(albumVC, animated: true)
        case .band:
            let bandVC = BandViewController(bandId: item.id, title: item.title)
            navigationController?.pushViewController(bandVC, animated: true)
        case .song:
            let songItem = item as? SongViewModelItem
            let albumVC = AlbumViewController(albumId: songItem?.albumId ?? 0, title: item.title)
            navigationController?.pushViewController(albumVC, animated: true)
        case .member:
            let memberVC = MemberViewController(memberId: item.id, title: item.title)
            navigationController?.pushViewController(memberVC, animated: true)
        }
    }
}
