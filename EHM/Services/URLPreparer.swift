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
    
    func prepareURL(for searchOrId: String, model: ModelsEnum) -> URL? {
        let dashedRequest = searchOrId.replacingOccurrences(of: " ", with: "-")
        let loweredRequest = dashedRequest.lowercased()
        let urlString = "http://\(backendIP):\(backendPORT)/\(model.rawValue)/\(loweredRequest)"
        let allowedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: allowedString ?? "")
        return url
    }
}
