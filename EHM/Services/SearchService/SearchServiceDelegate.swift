//
//  SearchServiceDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 13.11.2022.
//

import Foundation

protocol SearchServiceDelegate: AnyObject {
    func didRecieveSearchResult(result: SearchResultViewModel)
    func didFailToLoadData(error: Error)
}
