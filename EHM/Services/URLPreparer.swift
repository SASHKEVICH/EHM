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
    
    private func parse<T>(type: T.Type) -> String {
        switch type {
        case is Album.Type:
            return ModelsEnum.album.rawValue + "/one"
        case is Band.Type:
            return ModelsEnum.band.rawValue + "/one"
        case is Member.Type:
            return ModelsEnum.member.rawValue + "/one"
        case is Song.Type:
            return ModelsEnum.song.rawValue
        case is SearchResult.Type:
            return ModelsEnum.search.rawValue
        default:
            return ModelsEnum.album.rawValue + "/one"
        }
    }
    
    func prepareURL<T: Decodable>(for searchOrId: String, model: T.Type) -> URL? {
        let modelString = parse(type: model)
        let dashedRequest = searchOrId.replacingOccurrences(of: " ", with: "-")
        let loweredRequest = dashedRequest.lowercased()
        let urlString = "http://\(backendIP):\(backendPORT)/\(modelString)/\(loweredRequest)"
        let allowedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: allowedString ?? "")
        return url
    }
}
