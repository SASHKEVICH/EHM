//
//  SearchService.swift
//  EHM
//
//  Created by Александр Бекренев on 13.11.2022.
//

import Foundation

class SearchService: SearchServiceProtocol {
    private let networkClient: NetworkClient
    private let backendIP = ProcessInfo.processInfo.environment["BACKEND_IP"]
    private let backendPORT = ProcessInfo.processInfo.environment["BACKEND_PORT"]
    
    weak var delegate: SearchServiceDelegate?
    
    init(delegate: SearchServiceDelegate?) {
        self.delegate = delegate
        self.networkClient = NetworkClient.shared
    }
    
    public func requestSearch(with request: String) {
        let dashedRequest = request.replacingOccurrences(of: " ", with: "-")
        let ip = backendIP ?? "0"
        let port = backendPORT ?? "0"
        let urlString = "http://\(ip):\(port)/search/\(dashedRequest)"
        guard
            let allowedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let searchURL = URL(string: allowedString) else {
            delegate?.didFailToLoadData(error: SearchError.urlError)
            return
        }
        
        networkClient.fetch(url: searchURL) { [weak self] result in
            DispatchQueue.global().async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .failure(let error):
                    self.delegate?.didFailToLoadData(error: error)
                    print(error)
                case .success(let data):
                    self.handleSearchResult(with: data)
                }
            }
        }
    }
    
    private func handleSearchResult(with data: Data) {
        guard let searchResult = try? JSONDecoder().decode(SearchResult.self, from: data) else {
            delegate?.didFailToLoadData(error: SearchError.parsingJSON)
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let searchVM = self.convert(result: searchResult)
            if searchVM.items.isEmpty {
                self.delegate?.didFailToLoadData(error: SearchError.foundNoData)
            } else {
                self.delegate?.didRecieveSearchResult(result: searchVM)
            }
        }
    }
    
    private func convert(result: SearchResult) -> SearchResultViewModel {
        let vm = SearchResultViewModel(searchResult: result)
        return vm
    }
}
