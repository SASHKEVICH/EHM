//
//  ConstructError.swift
//  EHM
//
//  Created by Александр Бекренев on 17.01.2023.
//

import Foundation

enum ConstructError: Error, LocalizedError {
    case album
    case song
    case band
    case member

    public var errorDescription: String? {
        switch self {
        case .album:
            return NSLocalizedString("Unable to construct album", comment: "")
        case .song:
            return NSLocalizedString("Unable to construct song", comment: "")
        case .band:
            return NSLocalizedString("Unable to construct band", comment: "")
        case .member:
            return NSLocalizedString("Unable to construct member", comment: "")
        }
    }
}
