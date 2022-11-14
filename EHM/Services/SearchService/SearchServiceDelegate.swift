//
//  SearchServiceDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 13.11.2022.
//

import Foundation

protocol SearchServiceDelegate: AnyObject {
    func didRecieveSearchResult(result: SearchResult)
    func didFailToLoadData(error: Error)
}
