//
//  DataProviderDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 17.11.2022.
//

import Foundation

protocol DataProviderDelegate: AnyObject {
    func didRecieve(item: SearchResultViewModelItem)
    func didFailToLoadData(error: Error)
}
