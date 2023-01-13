//
//  SongDataProvider.swift
//  EHM
//
//  Created by Александр Бекренев on 27.11.2022.
//

import Foundation

class SongDataProvider: DataProviderProtocol {
    private let backendIP = ProcessInfo.processInfo.environment["BACKEND_IP"] ?? "0"
    private let backendPORT = ProcessInfo.processInfo.environment["BACKEND_PORT"] ?? "0"
    private let networkClient: NetworkClient
    
    weak var delegate: DataProviderDelegate?
    
    init(delegate: DataProviderDelegate) {
        self.delegate = delegate
        self.networkClient = NetworkClient.shared
    }
    
    func requestDataFor(id: Int) {
        guard let songURL = prepareSongURL(with: id) else {
            print("urlError")
//            delegate?.didFailToLoadData(error: SearchError.urlError)
            return
        }
        
        networkClient.fetch(url: songURL) { [weak self] result in
            DispatchQueue.global().async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .failure(let error):
                    print(error)
//                    delegate?.didFailToLoadData(error: SearchError.urlError)
                case .success(let data):
                    self.handleResult(with: data)
                }
            }
        }
    }
    
    private func prepareSongURL(with albumId: Int) -> URL? {
        let urlString = "http://\(backendIP):\(backendPORT)/songs/albumId=\(albumId)"
        let searchURL = URL(string: urlString)
        return searchURL
    }
    
    private func handleResult(with data: Data) {
        guard let songsData = try? JSONDecoder().decode(SongsProvidedData.self, from: data) else {
            print("decodingError")
            return
        }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if songsData.message == "failure" {
                print("some failure")
//                self.delegate?.didFailToLoadData(error: SearchError.foundNoData)
            } else {
                let songsVM = self.convertToViewModel(songs: songsData.info)
                self.delegate?.didRecieve(data: songsVM)
            }
        }
    }
    
    private func convertToViewModel(songs: [Song]) -> [SongViewModelItem] {
        let songsVM: [SongViewModelItem] = songs.compactMap { song -> SongViewModelItem? in
            guard let album = song.album?.first else { return nil }
            let songVM = SongViewModelItem(
                id: song.songId,
                albumId: album.albumId,
                title: song.title,
                album: album.title
            )
            songVM.duration = song.duration
            return songVM
        }
        return songsVM
    }
}
