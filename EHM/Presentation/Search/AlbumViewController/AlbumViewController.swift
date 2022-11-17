//
//  AlbumViewController.swift
//  EHM
//
//  Created by Александр Бекренев on 17.11.2022.
//

import UIKit

class AlbumViewController: UIViewController {
    private let albumId: Int
    private let navigationTitle: String
    private var dataRequester: DataProviderProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNavigation()
        dataRequester = DataProvider<Album>(delegate: self)
        dataRequester?.requestData(for: albumId)
    }
    
    init(albumId: Int, navigationTitle: String) {
        self.albumId = albumId
        self.navigationTitle = navigationTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    private func setupNavigation() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Альбом"
        navigationController?.navigationBar.tintColor = .ehmRed
    }
}
