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
        
//        do {
//            let bandData = try decoder.decode(BandProvidedData.self, from: data)
//        } catch let DecodingError.dataCorrupted(context) {
//            print(context)
//        } catch let DecodingError.keyNotFound(key, context) {
//            print("Key '\(key)' not found:", context.debugDescription)
//            print("codingPath:", context.codingPath)
//        } catch let DecodingError.valueNotFound(value, context) {
//            print("Value '\(value)' not found:", context.debugDescription)
//            print("codingPath:", context.codingPath)
//        } catch let DecodingError.typeMismatch(type, context)  {
//            print("Type '\(type)' mismatch:", context.debugDescription)
//            print("codingPath:", context.codingPath)
//        } catch {
//            print("error: ", error)
//        }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if bandData.message == "failure" {
                print("someFailure")
//                self.delegate?.didFailToLoadData(error: SearchError.foundNoData)
            } else {
                let band = bandData.info
                self.delegate?.didRecieve(data: band)
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
}
