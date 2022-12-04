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
                id: album.id,
                title: album.title,
                band: album.band ?? "some band",
                explicit: album.explicit ?? false)
            
            items.append(albumItem)
        }
        
        for band in searchResult.bands {
            let bandItem = BandViewModelItem(id: band.id, title: band.title)
            items.append(bandItem)
        }
        
        for song in searchResult.songs {
            let songItem = SongViewModelItem(id: song.id,
                                             albumId: song.albumId,
                                             title: song.title,
                                             album: song.album ?? "")
            items.append(songItem)
        }
        
        for member in searchResult.members {
            let memberItem = MemberViewModelItem(id: member.id, title: member.name)
            items.append(memberItem)
        }
    }
}
