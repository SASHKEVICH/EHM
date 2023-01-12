//
//  SearchService.swift
//  EHM
//
//  Created by Александр Бекренев on 13.11.2022.
//

import Foundation

class SearchService: SearchServiceProtocol {
    private let networkClient: NetworkClient
    
    weak var delegate: SearchServiceDelegate?
    
    init(delegate: SearchServiceDelegate?) {
        self.delegate = delegate
        self.networkClient = NetworkClient.shared
    }
    
    func search(with request: String) {
        let preparer = URLPreparer()
        guard let searchURL = preparer.prepareURL(for: request, model: ModelsEnum.search) else {
            delegate?.didFailToLoadData(error: SearchError.urlError)
            return
        }
        
        networkClient.fetch(url: searchURL) { [weak self] result in
            DispatchQueue.global().async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    self.handleSearchResult(with: data)
                case .failure(let error):
                    self.delegate?.didFailToLoadData(error: error)
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
