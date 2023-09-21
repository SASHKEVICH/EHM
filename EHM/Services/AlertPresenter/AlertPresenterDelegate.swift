//
//  AlertPresenterDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 16.11.2022.
//

import UIKit

protocol AlertPresenterDelegate: AnyObject {
    func didRecieveAlert(alert: UIAlertController)
    func makeRequest()
}
