//
//  NetworkClient.swift
//  EHM
//
//  Created by Александр Бекренев on 12.11.2022.
//

import Foundation

struct NetworkClient {
    static var shared: NetworkClient = {
        let client = NetworkClient()
        return client
    }()
    
    private init() {}
    
    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error as? URLError {
                handler(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse,
               response.statusCode < 200 || response.statusCode >= 300 {
                handler(.failure(NetworkError.codeError))
                return
            }
            
            guard let data = data else { return }
            handler(.success(data))
        }
        
        task.resume()
    }
}
