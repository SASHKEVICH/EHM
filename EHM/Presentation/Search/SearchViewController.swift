//
//  SearchViewController.swift
//  EHM
//
//  Created by Александр Бекренев on 09.11.2022.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    var searchTableView: UITableView?
    var searchService: SearchServiceProtocol?
    
    let searchTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: UITableView.Style.grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let searchBar: UISearchBar = {
        let textField = UISearchBar()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.barTintColor = .ehmBlack
        textField.isTranslucent = true
        textField.placeholder = "Sepultura"
        textField.layer.masksToBounds = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        view.backgroundColor = .ehmBlack
        navigationItem.title = "Поиск"
        setupTextField()
        
        searchService = SearchService(delegate: self)
    }
    
    // MARK: - Text Field
    private func setupTextField() {
        view.addSubview(searchBar)
        let constraints = [
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -13),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.heightAnchor.constraint(equalToConstant: 36)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
        
        searchBar.isHidden = true
        
    }
}
