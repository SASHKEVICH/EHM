//
//  DataConverterProtocol.swift
//  EHM
//
//  Created by Александр Бекренев on 14.01.2023.
//

import Foundation

protocol DataConverterProtocol {
    associatedtype TModel: Decodable
    associatedtype TViewModelItem: SearchResultViewModelItem
    
    func convertToViewModel(from: TModel) -> TViewModelItem
}
