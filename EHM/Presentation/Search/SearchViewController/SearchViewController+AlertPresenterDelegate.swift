//
//  SearchViewController+AlertPresenterDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 16.11.2022.
//

import Foundation
import UIKit

extension SearchViewController: AlertPresenterDelegate {
    func didRecieveAlert(alert: UIAlertController) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.present(alert, animated: true)
        }
    }
}
