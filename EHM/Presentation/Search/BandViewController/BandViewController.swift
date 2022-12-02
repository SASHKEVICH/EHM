//
//  BandViewController.swift
//  EHM
//
//  Created by Александр Бекренев on 17.11.2022.
//

// TODO: Напрашивается наследование

import UIKit

class BandViewController: UIViewController {
    private let bandId: Int
    private let navigationTitle: String
    
    private var bandDataProvider: DataProviderProtocol?
    
    var albums: [Album]?
    
    let bandScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bandStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    
    let discographyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.text = "Дискография"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let albumsCollectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let historyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let historyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.text = "История"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let historyTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        bandDataProvider = BandDataProvider(delegate: self)
        bandDataProvider?.requestDataFor(id: bandId)
        
        albumsCollectionView.dataSource = self
        albumsCollectionView.delegate = self
        albumsCollectionView.register(AlbumsCollectionViewCell.self, forCellWithReuseIdentifier: "AlbumsCollectionViewCell")
        
        setupViews()
    }
    
    init(bandId: Int, title: String) {
        self.bandId = bandId
        self.navigationTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    func setupViews() {
        setupNavigation()
        setupScrollView()
        setupAlbumCollection()
        setupHistory()
    }
    
    func present(band: Band) {
        
    }
    
    private func setupNavigation() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = navigationTitle
        navigationController?.navigationBar.tintColor = .ehmRed
    }
}
