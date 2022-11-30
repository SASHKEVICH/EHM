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
    private var albumDataProvider: DataProviderProtocol?
    private var songsDataProvider: DataProviderProtocol?
    
    var songs: [Song]?
    
    private let albumScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let albumStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .ehmRed
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .ehmGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let songsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    
    var songsTableViewHeight: NSLayoutConstraint?
    
    private let songsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Список композиций"
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let historyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "История"
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let historyTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private let albumTypeView: AdditionalInfoView = {
        return AdditionalInfoView(title: "Тип альбома")
    }()
    
    private let originView: AdditionalInfoView = {
        return AdditionalInfoView(title: "Город основания")
    }()
    
    private let releaseDateView: AdditionalInfoView = {
        return AdditionalInfoView(title: "Дата выхода")
    }()
    
    private let genresView: AdditionalInfoView = {
        return AdditionalInfoView(title: "Жанры")
    }()
    
    init(albumId: Int, navigationTitle: String) {
        self.albumId = albumId
        self.navigationTitle = navigationTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNavigation()
        setupScrollView()
        albumDataProvider = AlbumDataProvider(delegate: self)
        songsDataProvider = SongDataProvider(delegate: self)
        albumDataProvider?.requestDataFor(id: albumId)
        songsDataProvider?.requestDataFor(id: albumId)
        
        songsTableView.dataSource = self
        songsTableView.register(SongsTableCell.self, forCellReuseIdentifier: "SongsTableCell")
        songsTableView.isScrollEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    private func setupScrollView() {
        view.addSubview(albumScrollView)
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        albumScrollView.addSubview(contentView)
        contentView.addSubview(albumStackView)
        
        albumStackView.addSubview(albumCoverImageView)
        albumStackView.addSubview(titleLabel)
        albumStackView.addSubview(bandLabel)
        albumStackView.addSubview(songsLabel)
        albumStackView.addSubview(songsTableView)
        albumStackView.addSubview(historyLabel)
        albumStackView.addSubview(historyTextLabel)
        albumStackView.addSubview(albumTypeView)
        albumStackView.addSubview(originView)
        
        let constraints = [
            albumScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            albumScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            albumScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            albumScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: albumScrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: albumScrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: albumScrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: albumScrollView.contentLayoutGuide.trailingAnchor),
            contentView.heightAnchor.constraint(equalTo: albumScrollView.frameLayoutGuide.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: albumScrollView.frameLayoutGuide.widthAnchor),
            
            albumStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            albumStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            albumStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 23),
            albumStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -23),
            
            albumCoverImageView.topAnchor.constraint(equalTo: albumStackView.topAnchor, constant: 18),
            albumCoverImageView.widthAnchor.constraint(equalToConstant: 368),
            albumCoverImageView.heightAnchor.constraint(equalTo: albumCoverImageView.widthAnchor),
            albumCoverImageView.centerXAnchor.constraint(equalTo: albumStackView.centerXAnchor),

            titleLabel.topAnchor.constraint(equalTo: albumCoverImageView.bottomAnchor, constant: 25),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 23),
            titleLabel.centerXAnchor.constraint(equalTo: albumStackView.centerXAnchor),

            bandLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            bandLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 23),
            bandLabel.centerXAnchor.constraint(equalTo: albumStackView.centerXAnchor),
            
            songsLabel.leadingAnchor.constraint(equalTo: albumStackView.leadingAnchor),
            songsLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 23),
            songsLabel.topAnchor.constraint(equalTo: bandLabel.bottomAnchor, constant: 40),
            
            songsTableView.topAnchor.constraint(equalTo: songsLabel.bottomAnchor, constant: 10),
            songsTableView.leadingAnchor.constraint(equalTo: albumStackView.leadingAnchor),
            songsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            historyLabel.topAnchor.constraint(equalTo: songsTableView.bottomAnchor, constant: 40),
            historyLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 23),
            historyLabel.leadingAnchor.constraint(equalTo: albumStackView.leadingAnchor),
            
            historyTextLabel.topAnchor.constraint(equalTo: historyLabel.bottomAnchor, constant: 10),
            historyTextLabel.widthAnchor.constraint(equalTo: albumStackView.widthAnchor),
            historyTextLabel.centerXAnchor.constraint(equalTo: albumStackView.centerXAnchor),
            
            albumTypeView.topAnchor.constraint(equalTo: historyTextLabel.bottomAnchor, constant: 40),
            albumTypeView.leadingAnchor.constraint(equalTo: albumStackView.leadingAnchor),

            originView.topAnchor.constraint(equalTo: albumTypeView.bottomAnchor, constant: 15),
            originView.leadingAnchor.constraint(equalTo: albumStackView.leadingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupNavigation() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = navigationTitle
        navigationController?.navigationBar.tintColor = .ehmRed
    }
    
    private func sizingHistoryTextLabel() {
        historyTextLabel.sizeToFit()
        historyTextLabel.invalidateIntrinsicContentSize()
        historyTextLabel.heightAnchor.constraint(equalToConstant: historyTextLabel.intrinsicContentSize.height).isActive = true
        historyTextLabel.layoutIfNeeded()
    }
    
    func present(album: Album) {
        titleLabel.text = album.title
        titleLabel.sizeToFit()
//        titleLabel.invalidateIntrinsicContentSize()
//        titleLabel.heightAnchor.constraint(equalToConstant: historyTextLabel.intrinsicContentSize.height).isActive = true
        titleLabel.layoutIfNeeded()
        
        bandLabel.text = album.band
        bandLabel.sizeToFit()
        bandLabel.invalidateIntrinsicContentSize()
        bandLabel.layoutIfNeeded()
        
        historyTextLabel.text = album.history
        sizingHistoryTextLabel()
    }
}
