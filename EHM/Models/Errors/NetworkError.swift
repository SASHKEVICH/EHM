//
//  NetworkError.swift
//  EHM
//
//  Created by Александр Бекренев on 03.12.2022.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case codeError
    case serverUnavailable

    public var errorDescription: String? {
        switch self {
        case .codeError:
            return NSLocalizedString("Failure code", comment: "")
        case .serverUnavailable:
            return NSLocalizedString("Server unavailable", comment: "")
        }
    }
}
