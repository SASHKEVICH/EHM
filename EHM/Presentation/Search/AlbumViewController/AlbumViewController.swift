//
//  AlbumViewController.swift
//  EHM
//
//  Created by Александр Бекренев on 17.11.2022.
//

import SnapKit
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
    
    let contentView: UIView = {
        return UIView()
    }()
    
    private let albumStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
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
    
    var songsTableViewHeightConstraint: Constraint? = nil
    
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
    
    private var dynamicLabels: [UILabel]? = nil
    
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        dynamicLabels = [titleLabel, bandLabel, historyTextLabel]
        
        setupViews()
        
        albumDataProvider = AlbumDataProvider(delegate: self)
        songsDataProvider = SongDataProvider(delegate: self)
        albumDataProvider?.requestDataFor(id: albumId)
        songsDataProvider?.requestDataFor(id: albumId)
        
        songsTableView.dataSource = self
        songsTableView.register(SongsTableCell.self, forCellReuseIdentifier: "SongsTableCell")
        songsTableView.isScrollEnabled = false
    }
    
    override func updateViewConstraints() {
        updateConstraintsFor(labels: dynamicLabels)
        songsTableView.snp.updateConstraints { make in
            make.height.equalTo(songsTableView.contentSize.height)
        }
        
        super.updateViewConstraints()
    }
    
    private func setupViews() {
        setupNavigation()
        setupScrollView()
        setupHeader()
        setupSongs()
        setupHistory()
    }
    
    private func setupScrollView() {
        view.addSubview(albumScrollView)
        albumScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        albumScrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(albumScrollView.contentLayoutGuide.snp.edges)
            make.width.equalTo(albumScrollView.frameLayoutGuide.snp.width)
            make.height.equalTo(albumScrollView.frameLayoutGuide.snp.height)
        }
        
        contentView.addSubview(albumStackView)
        albumStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(23)
            make.verticalEdges.equalTo(contentView.snp.verticalEdges)
        }
    }
    
    private func setupHeader() {
        let headerView = UIView()
        headerView.addSubview(albumCoverImageView)
        headerView.addSubview(titleLabel)
        headerView.addSubview(bandLabel)
        
        albumStackView.addArrangedSubview(headerView)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(albumStackView.snp.top).offset(18)
            make.centerX.equalTo(albumStackView.snp.centerX)
            make.width.equalTo(albumStackView.snp.width)
        }
        
        albumCoverImageView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.top)
            make.centerX.equalTo(headerView.snp.centerX)
            make.size.equalTo(368)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(albumCoverImageView.snp.bottom).offset(25)
            make.centerX.equalTo(headerView.snp.centerX)
            make.height.equalTo(0)
        }
        
        bandLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.centerX.equalTo(headerView.snp.centerX)
            make.height.equalTo(0)
        }
    }
    
    private func setupSongs() {
        albumStackView.addArrangedSubview(songsLabel)
        songsLabel.snp.makeConstraints { make in
            make.top.equalTo(bandLabel.snp.bottom).offset(40)
            make.leading.equalTo(albumStackView.snp.leading)
            make.height.equalTo(22)
        }
        
        albumStackView.addArrangedSubview(songsTableView)
        songsTableView.snp.makeConstraints { make in
            make.top.equalTo(songsLabel.snp.bottom).offset(10)
            make.leading.equalTo(albumStackView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.height.equalTo(0)
        }
    }
    
    private func setupHistory() {
        albumStackView.addArrangedSubview(historyLabel)
        historyLabel.snp.makeConstraints { make in
            make.top.equalTo(songsTableView.snp.bottom).offset(40)
            make.leading.equalTo(albumStackView.snp.leading)
            make.height.equalTo(22)
        }
        
        albumStackView.addArrangedSubview(historyTextLabel)
        historyTextLabel.snp.makeConstraints { make in
            make.top.equalTo(historyLabel.snp.bottom).offset(10)
            make.leading.equalTo(albumStackView.snp.leading)
            make.height.equalTo(0)
        }
    }
    
    func present(album: Album) {
        titleLabel.text = album.title
        bandLabel.text = album.band
        historyTextLabel.text = album.history
        
        size(labels: dynamicLabels)
    }
    
    private func setupNavigation() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = navigationTitle
        navigationController?.navigationBar.tintColor = .ehmRed
    }
    
    private func sizingHistoryTextLabel() {
        historyTextLabel.sizeToFit()
        historyTextLabel.invalidateIntrinsicContentSize()
    }
    
    private func size(labels: [UILabel]?) {
        guard let labels = labels else { return }
        for label in labels {
            label.sizeToFit()
            label.invalidateIntrinsicContentSize()
        }
        view.setNeedsUpdateConstraints()
    }
    
    private func updateConstraintsFor(labels: [UILabel]?) {
        guard let labels = labels else { return }
        
        for label in labels {
            label.snp.updateConstraints { make in
                make.height.equalTo(label.intrinsicContentSize.height)
            }
        }
    }
}
