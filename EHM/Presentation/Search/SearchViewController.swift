//
//  SearchViewController.swift
//  EHM
//
//  Created by Александр Бекренев on 09.11.2022.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    var searchService: SearchServiceProtocol?
    var searchResult: SearchResultViewModel?

    var searchTableViewController: UITableViewController = UITableViewController(style: .plain)
    
    let searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    
    let searchBar: UISearchBar = {
        let textField = UISearchBar(frame: CGRect(x: 0, y: 0, width: 375, height: 36))
        textField.barTintColor = .ehmBlack
        textField.backgroundColor = .ehmBlack
        textField.tintColor = .ehmRed
        textField.placeholder = "Sepultura"
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ehmBlack
        view.addSubview(searchTableView)
        
        navigationItem.title = "Поиск"
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = .ehmBlack
        
        searchService = SearchService(delegate: self)
        
        setupTableView()
        searchBar.delegate = self
        
//        searchService?.requestSearch(with: "Metallica")
    }
    
    // MARK: - Table View
    private func setupTableView() {
        let constraints = [
            searchTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            searchTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        searchTableView.sectionHeaderTopPadding = 0
        searchTableView.register(AlbumCell.self, forCellReuseIdentifier: "AlbumCell")
        searchTableView.register(BandCell.self, forCellReuseIdentifier: "BandCell")
        searchTableView.register(SongCell.self, forCellReuseIdentifier: "SongCell")
        searchTableView.dataSource = self
        searchTableView.delegate = self
    }
}
