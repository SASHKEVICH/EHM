//
//  JSONParser.swift
//  EHM
//
//  Created by Александр Бекренев on 13.01.2023.
//

import Foundation

struct JSONParser {
    static func parse<TModel: Decodable>(from data: Data) -> TModel? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let result = try decoder.decode(TModel.self, from: data)
            return result
        } catch {
            print(error)
            return nil
        }

    }
}
