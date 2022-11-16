//
//  SearchError.swift
//  EHM
//
//  Created by Александр Бекренев on 16.11.2022.
//

import Foundation

enum SearchError: Error, LocalizedError {
    case parsingJSON
    case urlError
    case foundNoData
    
    public var errorDescription: String? {
        switch self {
        case .parsingJSON:
            return NSLocalizedString("Failed to parse search result JSON", comment: "")
        case .urlError:
            return NSLocalizedString("Unable to construct search url", comment: "")
        case .foundNoData:
            return NSLocalizedString("По вашему запросу ничего не найдено", comment: "")
        }
    }
}
