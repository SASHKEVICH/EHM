//
//  MemberDataProvider.swift
//  EHM
//
//  Created by Александр Бекренев on 04.12.2022.
//

import Foundation

class MemberDataProvider: DataProviderProtocol {
    private let backendIP = ProcessInfo.processInfo.environment["BACKEND_IP"] ?? "0"
    private let backendPORT = ProcessInfo.processInfo.environment["BACKEND_PORT"] ?? "0"
    private let networkClient: NetworkClient
    
    weak var delegate: DataProviderDelegate?
    
    init(delegate: DataProviderDelegate) {
        self.delegate = delegate
        self.networkClient = NetworkClient.shared
    }
    
    private func prepareMemberURL(with memberId: Int) -> URL? {
        let urlString = "http://\(backendIP):\(backendPORT)/members/\(memberId)"
        let searchURL = URL(string: urlString)
        return searchURL
    }
    
    private func handleResult(with data: Data) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let memberData = try? decoder.decode(MemberProvidedData.self, from: data) else {
            print("decodingError")
//            delegate?.didFailToLoadData(error: SearchError.urlError)
            return
        }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if memberData.message == "failure" {
                print("someFailure")
//                self.delegate?.didFailToLoadData(error: SearchError.foundNoData)
            } else {
                let member = memberData.info
                self.delegate?.didRecieve(data: member)
            }
        }
    }
    
    func requestDataFor(id: Int) {
        guard let memberURL = prepareMemberURL(with: id) else {
            print("urlError")
//            delegate?.didFailToLoadData(error: SearchError.urlError)
            return
        }
        
        networkClient.fetch(url: memberURL) { [weak self] result in
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
