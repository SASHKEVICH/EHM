//
//  DataProvider.swift
//  EHM
//
//  Created by Александр Бекренев on 17.11.2022.
//

import Foundation

class DataProvider<T>: DataProviderProtocol {
    private let networkClient: NetworkClient
    weak var delegate: DataProviderDelegate?
    
    init(delegate: DataProviderDelegate) {
        self.delegate = delegate
        self.networkClient = NetworkClient.shared
    }
    
    func requestData(for: Int) {
        
    }
}
