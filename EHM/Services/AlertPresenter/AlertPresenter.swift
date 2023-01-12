//
//  AlertPresenter.swift
//  EHM
//
//  Created by Александр Бекренев on 16.11.2022.
//

import UIKit

class AlertPresenter {
    private var delegate: AlertPresenterDelegate?
    
    init(delegate: AlertPresenterDelegate) {
        self.delegate = delegate
    }
    
    func requestPresentAlert(for error: Error) {
        let alertModel = AlertModel(
            title: "Что-то пошло не так",
            message: error.localizedDescription,
            buttonText: "Попробовать снова",
            completion: computeCompletion(for: error)
        )
        let alert = prepareAlert(for: alertModel)
        delegate?.didRecieveAlert(alert: alert)
    }
    
    private func prepareAlert(for result: AlertModel) -> UIAlertController {
        let alert = UIAlertController(
            title: result.title,
            message: result.message,
            preferredStyle: .alert
        )
        
        let alertAction = UIAlertAction(title: result.buttonText,
                                        style: .default,
                                        handler: result.completion
        )
        
        alert.addAction(alertAction)
        return alert
    }
    
    private func computeCompletion(for error: Error) -> (UIAlertAction) -> Void {
        let completion: (UIAlertAction) -> Void
        switch error {
        case is SearchError, is URLError:
            completion = { _ in }
        default:
            completion = { [weak self] _ in
                self?.delegate?.makeRequest()
            }
        }
        return completion
    }
}
