//
//  SearchViewController.swift
//  EHM
//
//  Created by Александр Бекренев on 09.11.2022.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "Sepultura"
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ehmBlack
        navigationItem.title = "Поиск"
        setupTextField()
    }
    
    private func setupTextField() {
        addLeftViewToTextField()
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.delegate = self
        
        view.addSubview(searchTextField)
        let constraints = [
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchTextField.heightAnchor.constraint(equalToConstant: 36)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addLeftViewToTextField() {
        let glassView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        glassView.tintColor = .ehmGray
        glassView.sizeToFit()
        
        let leftView = UIView()
        leftView.addSubview(glassView)
        leftView.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        glassView.frame = CGRect(x: 8, y: 2, width: 17, height: 16)
        searchTextField.leftView = leftView
        
        searchTextField.leftViewMode = .always
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
