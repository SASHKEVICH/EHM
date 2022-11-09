//
//  SearchViewController.swift
//  EHM
//
//  Created by Александр Бекренев on 09.11.2022.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    private let searchLabel: UILabel = {
        let label = UILabel()
        label.text = "Поиск"
        label.textColor = .white
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ehmBlack
        view.addSubview(searchLabel)
        
        let constraints = [
            searchLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
