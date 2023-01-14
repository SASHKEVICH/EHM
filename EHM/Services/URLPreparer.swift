//
//  URLPreparer.swift
//  EHM
//
//  Created by Александр Бекренев on 12.01.2023.
//

import Foundation

struct URLPreparer {
    private let backendIP = ProcessInfo.processInfo.environment["BACKEND_IP"] ?? "0"
    private let backendPORT = ProcessInfo.processInfo.environment["BACKEND_PORT"] ?? "0"
    
    private func parseTypeToModelEnum<T>(type: T.Type) -> ModelsEnum {
        switch type {
        case is Album.Type:
            return ModelsEnum.album
        case is Band.Type:
            return ModelsEnum.band
        case is Member.Type:
            return ModelsEnum.member
        case is Song.Type:
            return ModelsEnum.song
        case is SearchResult.Type:
            return ModelsEnum.search
        default:
            return ModelsEnum.album
        }
    }
    
    func prepareURL<T: Decodable>(for searchOrId: String, model: T.Type) -> URL? {
        let model = parseTypeToModelEnum(type: model)
        let dashedRequest = searchOrId.replacingOccurrences(of: " ", with: "-")
        let loweredRequest = dashedRequest.lowercased()
        let urlString = "http://\(backendIP):\(backendPORT)/\(model.rawValue)/\(loweredRequest)"
        let allowedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: allowedString ?? "")
        return url
    }
}
