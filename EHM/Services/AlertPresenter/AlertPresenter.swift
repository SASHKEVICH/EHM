//
//  AlertPresenter.swift
//  EHM
//
//  Created by Александр Бекренев on 16.11.2022.
//

import Foundation
import UIKit

class AlertPresenter {
    private var delegate: AlertPresenterDelegate?
    
    init(delegate: AlertPresenterDelegate) {
        self.delegate = delegate
    }
    
    func requestPresentAlert(title: String, message: String, buttonText: String, completion: @escaping (UIAlertAction) -> Void) {
        let alertModel = AlertModel(
            title: title,
            message: message,
            buttonText: buttonText,
            completion: completion)
        let alert = prepareAlert(for: alertModel)
        delegate?.didRecieveAlert(alert: alert)
    }
    
    private func prepareAlert(for result: AlertModel) -> UIAlertController {
        let alert = UIAlertController(
            title: result.title,
            message: result.message,
            preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: result.buttonText,
                                        style: .default,
                                        handler: result.completion)
        alert.addAction(alertAction)
        return alert
    }
}
