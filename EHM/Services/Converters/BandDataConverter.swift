//
//  BandDataConverter.swift
//  EHM
//
//  Created by Александр Бекренев on 14.01.2023.
//

import Foundation

struct BandDataConverter: DataConverterProtocol {
    typealias TModel = Band
    typealias TViewModelItem = BandViewModelItem
    
    func convertToViewModel(from band: Band) -> BandViewModelItem {
        let bandVM = BandViewModelItem(id: band.bandId, title: band.title)
        let imageLoader = ImageLoader()
        bandVM.cover = imageLoader.load(from: band.photoPath)
        bandVM.origin = band.getOrigin()
        bandVM.years = band.getYears()
        bandVM.genres = band.getGenres()
        bandVM.albums = band.albums?.map { album in
            let albumVM = AlbumViewModelItem(
                id: album.albumId,
                title: album.title,
                band: album.band?.first?.title ?? "some band",
                explicit: album.explicit ?? false
            )
            albumVM.cover = imageLoader.load(from: album.albumCoverPath)
            return albumVM
        }
        
        bandVM.members = band.members?.map { member in
            let memberVM = MemberViewModelItem(id: member.memberId, title: member.name)
            return memberVM
        }
        return bandVM
    }
}
