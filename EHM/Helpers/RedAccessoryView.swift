//
//  RedAccessoryView.swift
//  EHM
//
//  Created by Александр Бекренев on 04.12.2022.
//

import Foundation
import UIKit

extension UIImageView {
    var redAccessory: UIImageView {
        guard let image = UIImage(systemName: "chevron.right") else { return UIImageView() }
        let chevron  = UIImageView(frame:CGRect(x:0, y:0, width:(image.size.width), height:(image.size.height)));
        chevron.image = image
        return chevron
    }
}
