//
//  ImageLoader.swift
//  EHM
//
//  Created by Александр Бекренев on 06.12.2022.
//

import UIKit

struct ImageLoader {
    func load(from path: String?) -> UIImage? {
        guard
            let path = path,
            let pathURL = URL(string: path) else { return nil }
        do {
            let imageData = try Data(contentsOf: pathURL)
            let image = UIImage(data: imageData)
            return image
        } catch {
            print(error)
        }
        
        return UIImage()
    }
}
