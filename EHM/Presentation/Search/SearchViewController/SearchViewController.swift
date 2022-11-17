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
    var alertPresenter: AlertPresenter?

    let searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    
    let searchController: UISearchController = {
        let search = UISearchController()
        search.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Sepultura",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.ehmGray60]
        )
        search.searchBar.tintColor = .ehmRed
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ehmBlack
        view.addSubview(searchTableView)
        searchTableView.backgroundColor = .black
        
        navigationItem.title = "Поиск"
        navigationItem.backButtonTitle = ""
        
        setupNavigationBar()
        searchService = SearchService(delegate: self)
        alertPresenter = AlertPresenter(delegate: self)
        
        setupTableView()
        searchController.searchBar.delegate = self
    }
    
    // MARK: - Navigation Bar
    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = .ehmDarkGray
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        
        navigationItem.searchController = searchController
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
