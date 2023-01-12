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
    
    var searchRequest: String?

    let searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    
    let searchController: UISearchController = {
        let search = UISearchController()
        search.view.translatesAutoresizingMaskIntoConstraints = false
        search.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Sepultura",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.ehmGray60]
        )
        search.searchBar.tintColor = .ehmRed
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchTableView)
        searchTableView.backgroundColor = .ehmBlack
        
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
        navBarAppearance.backgroundColor = .ehmBlack
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.searchController = searchController
    }
    
    // MARK: - Table View
    private func setupTableView() {
        searchTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        searchTableView.sectionHeaderTopPadding = 0
        searchTableView.register(AlbumCell.self, forCellReuseIdentifier: "AlbumCell")
        searchTableView.register(BandCell.self, forCellReuseIdentifier: "BandCell")
        searchTableView.register(SongCell.self, forCellReuseIdentifier: "SongCell")
        searchTableView.register(MemberCell.self, forCellReuseIdentifier: "MemberCell")
        searchTableView.dataSource = self
        searchTableView.delegate = self
    }
}
