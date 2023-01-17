//
//  AlbumDataConverter.swift
//  EHM
//
//  Created by Александр Бекренев on 14.01.2023.
//

import Foundation

struct AlbumDataConverter: DataConverterProtocol {
    typealias TModel = Album
    typealias TViewModelItem = AlbumViewModelItem
    
    func convertToViewModel(from album: Album) -> AlbumViewModelItem {
        let imageLoader = ImageLoader()
        let albumVM = AlbumViewModelItem(
            id: album.albumId,
            title: album.title,
            band: album.band?.first?.title ?? "some band",
            explicit: album.explicit ?? false
        )
        albumVM.cover = imageLoader.load(from: album.albumCoverPath)
        albumVM.released = album.released?.dateString
        albumVM.genres = album.getGenres()
        albumVM.history = album.history
        albumVM.albumType = album.type
        return albumVM
    }
}
