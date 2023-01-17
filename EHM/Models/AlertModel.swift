//
//  AlertModel.swift
//  EHM
//
//  Created by Александр Бекренев on 16.11.2022.
//

import UIKit

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: (UIAlertAction) -> Void
}
