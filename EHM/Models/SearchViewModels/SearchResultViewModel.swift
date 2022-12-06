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
        super.init()
        let imageLoader = ImageLoader()
        for album in searchResult.albums {
            let albumItem = AlbumViewModelItem(
                id: album.id,
                title: album.title,
                band: album.band ?? "some band",
                explicit: album.explicit ?? false)
            
            let cover = imageLoader.load(from: album.coverPath)
            albumItem.cover = cover
            items.append(albumItem)
        }
        
        for band in searchResult.bands {
            let bandItem = BandViewModelItem(id: band.id, title: band.title)
            let cover = imageLoader.load(from: band.cover)
            bandItem.cover = cover
            items.append(bandItem)
        }
        
        for song in searchResult.songs {
            let songItem = SongViewModelItem(id: song.id,
                                             albumId: song.albumId,
                                             title: song.title,
                                             album: song.album ?? "")
            let cover = imageLoader.load(from: song.coverPath)
            songItem.cover = cover
            items.append(songItem)
        }
        
        for member in searchResult.members {
            let memberItem = MemberViewModelItem(id: member.id, title: member.name)
            let cover = imageLoader.load(from: member.cover)
            memberItem.cover = cover
            items.append(memberItem)
        }
    }
}
