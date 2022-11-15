//
//  SearchViewController+UITableViewDataSource.swift
//  EHM
//
//  Created by Александр Бекренев on 14.11.2022.
//

import Foundation
import UIKit

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = searchResult?.items[indexPath.item] else {
            fatalError("something went wrong in cells...")
        }
        
        switch item.type {
        case .album:
            if let cell = searchTableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as? AlbumCell {
                cell.item = item
                return cell
            }
        case .band:
            if let cell = searchTableView.dequeueReusableCell(withIdentifier: "BandCell", for: indexPath) as? BandCell {
                cell.item = item
                return cell
            }
        case .song:
            if let cell = searchTableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongCell {
                cell.item = item
                return cell
            }
        }
        
        return UITableViewCell()
    }
}
