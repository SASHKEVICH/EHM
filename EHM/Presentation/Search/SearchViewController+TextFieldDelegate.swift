//
//  SearchViewController+TextFieldDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 12.11.2022.
//

import Foundation
import UIKit

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        guard let request = searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return false
        }
        if request != "" {
            searchService?.requestSearch(with: request)
        }
        return false
    }
}
