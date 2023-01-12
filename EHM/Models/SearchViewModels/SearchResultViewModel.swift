//
//  SearchResultViewModel.swift
//  EHM
//
//  Created by Александр Бекренев on 14.11.2022.
//

import UIKit

class SearchResultViewModel: NSObject {
    var items = [SearchResultViewModelItem]()
    
    init(searchResult: SearchResult) {
        super.init()
        let imageLoader = ImageLoader()
        
        convertAlbumToViewModel(searchResult: searchResult, imageLoader)
        convertBandToViewModel(searchResult: searchResult, imageLoader)
        convertSongToViewModel(searchResult: searchResult, imageLoader)
        convertMemberToViewModel(searchResult: searchResult, imageLoader)
    }
    
    private func convertAlbumToViewModel(searchResult: SearchResult, _ imageLoader: ImageLoader) {
        for album in searchResult.albums {
            let albumItem = AlbumViewModelItem(
                id: album.albumId,
                title: album.title,
                band: album.band?.title ?? "some band",
                explicit: album.explicit ?? false
            )
            
            albumItem.cover = imageLoader.load(from: album.albumCoverPath)
            items.append(albumItem)
        }
    }
    
    private func convertBandToViewModel(searchResult: SearchResult, _ imageLoader: ImageLoader) {
        for album in searchResult.albums {
            let albumItem = AlbumViewModelItem(
                id: album.albumId,
                title: album.title,
                band: album.band?.title ?? "some band",
                explicit: album.explicit ?? false
            )
            
            albumItem.cover = imageLoader.load(from: album.albumCoverPath)
            items.append(albumItem)
        }
    }
    
    private func convertSongToViewModel(searchResult: SearchResult, _ imageLoader: ImageLoader) {
        for song in searchResult.songs {
            guard let album = song.album?.first else {
                assertionFailure("Song has no album")
                continue
            }
            let songItem = SongViewModelItem(
                id: song.songId,
                albumId: album.albumId,
                title: song.title,
                album: album.title
            )
            songItem.cover = imageLoader.load(from: album.albumCoverPath)
            items.append(songItem)
        }
    }
    
    private func convertMemberToViewModel(searchResult: SearchResult, _ imageLoader: ImageLoader) {
        for album in searchResult.albums {
            let albumItem = AlbumViewModelItem(
                id: album.albumId,
                title: album.title,
                band: album.band?.title ?? "some band",
                explicit: album.explicit ?? false
            )
            
            albumItem.cover = imageLoader.load(from: album.albumCoverPath)
            items.append(albumItem)
        }
    }
}
