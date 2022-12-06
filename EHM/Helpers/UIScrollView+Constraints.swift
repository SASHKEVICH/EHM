//
//  UIScrollView+Constraints.swift
//  EHM
//
//  Created by Александр Бекренев on 06.12.2022.
//

import Foundation
import UIKit

extension UIScrollView {
    func makeStandardConstraints() {
        self.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
