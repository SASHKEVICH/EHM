//
//  SearchService.swift
//  EHM
//
//  Created by Александр Бекренев on 13.11.2022.
//

import Foundation

class SearchService: SearchServiceProtocol {
    private let networkClient: NetworkClient
    private let backendIP = ProcessInfo.processInfo.environment["BACKEND_IP"] ?? "0"
    private let backendPORT = ProcessInfo.processInfo.environment["BACKEND_PORT"] ?? "0"
    
    weak var delegate: SearchServiceDelegate?
    
    init(delegate: SearchServiceDelegate?) {
        self.delegate = delegate
        self.networkClient = NetworkClient.shared
    }
    
    func search(with request: String) {
        guard let searchURL = prepareSearchURL(with: request) else {
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
    
    private func prepareSearchURL(with request: String) -> URL? {
        let dashedRequest = request.replacingOccurrences(of: " ", with: "-")
        let loweredRequest = dashedRequest.lowercased()
        let urlString = "http://\(backendIP):\(backendPORT)/search/\(loweredRequest)"
        let allowedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let searchURL = URL(string: allowedString ?? "")
        return searchURL
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
