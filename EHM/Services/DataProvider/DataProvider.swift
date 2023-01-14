//
//  DataProvider.swift
//  EHM
//
//  Created by Александр Бекренев on 14.01.2023.
//

import Foundation

class DataProvider<TModel: Decodable, TConverter: DataConverterProtocol> {
    private let networkClient: NetworkClient = NetworkClient.shared
    private let dataConverter: TConverter
    
    private weak var delegate: DataProviderDelegate?
    
    init(delegate: DataProviderDelegate, dataConverter: TConverter) {
        self.delegate = delegate
        self.dataConverter = dataConverter
    }
    
    func requestDataFor(id: Int) {
        let urlPreparer = URLPreparer()
        guard let url = urlPreparer.prepareURL(for: String(id), model: TConverter.TModel.self) else {
//            delegate?.didFailToLoadData(error: SearchError.urlError)
            return
        }
        
        networkClient.fetch(url: url) { [weak self] result in
            DispatchQueue.global().async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    self.handleResult(with: data)
                case .failure(let error):
                    print(error)
//                    delegate?.didFailToLoadData(error: SearchError.urlError)
                }
            }
        }
    }
    
    private func handleResult(with data: Data) {
        guard let modelData: TConverter.TModel = JSONParser.parse(from: data) else {
            print("decodingError")
//            delegate?.didFailToLoadData(error: SearchError.urlError)
            return
        }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let viewModel = self.dataConverter.convertToViewModel(from: modelData)
            self.delegate?.didRecieve(data: viewModel)
        }
    }
}
