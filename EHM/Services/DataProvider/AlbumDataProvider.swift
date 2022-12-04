//
//  DataProvider.swift
//  EHM
//
//  Created by Александр Бекренев on 17.11.2022.
//

import Foundation

// TODO: Напрашивается Generic

class AlbumDataProvider: DataProviderProtocol {
    private let backendIP = ProcessInfo.processInfo.environment["BACKEND_IP"] ?? "0"
    private let backendPORT = ProcessInfo.processInfo.environment["BACKEND_PORT"] ?? "0"
    private let networkClient: NetworkClient
    
    weak var delegate: DataProviderDelegate?
    
    init(delegate: DataProviderDelegate) {
        self.delegate = delegate
        self.networkClient = NetworkClient.shared
    }
    
    private func prepareAlbumURL(with albumId: Int) -> URL? {
        let urlString = "http://\(backendIP):\(backendPORT)/albums/\(albumId)"
        let searchURL = URL(string: urlString)
        return searchURL
    }
    
    private func handleResult(with data: Data) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let albumData = try? decoder.decode(AlbumProvidedData.self, from: data) else {
            print("decodingError")
//            delegate?.didFailToLoadData(error: SearchError.urlError)
            return
        }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if albumData.message == "failure" {
                print("someFailure")
//                self.delegate?.didFailToLoadData(error: SearchError.foundNoData)
            } else {
                let album = albumData.info
                self.delegate?.didRecieve(data: album)
            }
        }
    }
    
    func requestDataFor(id: Int) {
        guard let albumURL = prepareAlbumURL(with: id) else {
            print("urlError")
//            delegate?.didFailToLoadData(error: SearchError.urlError)
            return
        }
        
        networkClient.fetch(url: albumURL) { [weak self] result in
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
}
