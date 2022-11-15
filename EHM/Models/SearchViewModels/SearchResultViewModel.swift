//
//  SearchResultViewModel.swift
//  EHM
//
//  Created by Александр Бекренев on 14.11.2022.
//

import Foundation
import UIKit

class SearchResultViewModel: NSObject {
    var items = [SearchResultViewModelItem]()
    
    init(searchResult: SearchResult) {
        for album in searchResult.albums {
            let albumItem = AlbumViewModelItem(
                title: album.title,
                band: album.band,
                explicit: album.explicit)
            
            items.append(albumItem)
        }
        
        for band in searchResult.bands {
            let bandItem = BandViewModelItem(title: band.title)
            items.append(bandItem)
        }
        
        for song in searchResult.songs {
            let songItem = SongViewModelItem(title: song.title, album: song.album)
            items.append(songItem)
        }
    }
}