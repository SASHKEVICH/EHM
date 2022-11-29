//
//  AlbumViewController+UITableViewDataSource.swift
//  EHM
//
//  Created by Александр Бекренев on 29.11.2022.
//

import Foundation
import UIKit

extension AlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let songs = songs else {
            fatalError("something went wrong in cells...")
        }
        let song = songs[indexPath.item]
        let duration = song.duration ?? "00:00"
        let cell = songsTableView.dequeueReusableCell(withIdentifier: "SongsTableCell") as? SongsTableCell
        cell?.set(index: String(indexPath.row + 1), title: song.title, duration: duration)
        return cell ?? UITableViewCell()
    }
}
