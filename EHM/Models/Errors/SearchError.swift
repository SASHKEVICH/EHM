//
//  SearchError.swift
//  EHM
//
//  Created by Александр Бекренев on 16.11.2022.
//

import Foundation

enum SearchError: Error, LocalizedError {
    case decodingError
    case urlError
    case foundNoData
    
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return NSLocalizedString("Failed to parse JSON", comment: "")
        case .urlError:
            return NSLocalizedString("Unable to construct url", comment: "")
        case .foundNoData:
            return NSLocalizedString("По вашему запросу ничего не найдено", comment: "")
        }
    }
}
