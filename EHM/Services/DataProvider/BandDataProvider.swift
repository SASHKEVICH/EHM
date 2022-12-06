//
//  BandDataProvider.swift
//  EHM
//
//  Created by Александр Бекренев on 02.12.2022.
//

import Foundation

class BandDataProvider: DataProviderProtocol {
    private let backendIP = ProcessInfo.processInfo.environment["BACKEND_IP"] ?? "0"
    private let backendPORT = ProcessInfo.processInfo.environment["BACKEND_PORT"] ?? "0"
    private let networkClient: NetworkClient
    
    weak var delegate: DataProviderDelegate?
    
    init(delegate: DataProviderDelegate) {
        self.delegate = delegate
        self.networkClient = NetworkClient.shared
    }
    
    private func prepareBandURL(with bandId: Int) -> URL? {
        let urlString = "http://\(backendIP):\(backendPORT)/bands/\(bandId)"
        let searchURL = URL(string: urlString)
        return searchURL
    }
    
    private func handleResult(with data: Data) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let bandData = try? decoder.decode(BandProvidedData.self, from: data) else {
            print("decodingError")
//            delegate?.didFailToLoadData(error: SearchError.urlError)
            return
        }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if bandData.message == "failure" {
                print("someFailure")
//                self.delegate?.didFailToLoadData(error: SearchError.foundNoData)
            } else {
                let bandVM = self.convertToViewModel(band: bandData.info)
                self.delegate?.didRecieve(data: bandVM)
            }
        }
    }
    
    func requestDataFor(id: Int) {
        guard let albumURL = prepareBandURL(with: id) else {
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
    
    private func convertToViewModel(band: Band) -> BandViewModelItem {
        let bandVM = BandViewModelItem(id: band.id, title: band.title)
        let imageLoader = ImageLoader()
        bandVM.cover = imageLoader.load(from: band.cover)
        bandVM.origin = band.getOrigin()
        bandVM.years = band.getYears()
        bandVM.genres = band.getGenres()
        bandVM.albums = band.albums?.map { album in
            let albumVM = AlbumViewModelItem(id: album.id, title: album.title, band: album.band ?? "", explicit: album.explicit ?? false)
            albumVM.cover = imageLoader.load(from: album.coverPath)
            return albumVM
        }
        
        bandVM.currentMembers = band.currentMembers?.map { member in
            let memberVM = MemberViewModelItem(id: member.id, title: member.name)
            return memberVM
        }
        
        bandVM.previousMembers = band.previousMembers?.map { member in
            let memberVM = MemberViewModelItem(id: member.id, title: member.name)
            return memberVM
        }
        return bandVM
    }
}
