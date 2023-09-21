//
//  AlbumViewController.swift
//  EHM
//
//  Created by Александр Бекренев on 17.11.2022.
//

import UIKit

final class AlbumViewController: UIViewController {
    private let albumId: Int
    private let navigationTitle: String

    private(set) var alertPresenter: AlertPresenter?
    private(set) var pdfService: PDFService<Album>?
    private var albumDataProvider: DataProviderProtocol?

    var songs: [SongViewModelItem]?

    let albumScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let albumStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let headerStackView: UIStackView = {
        let headerView = UIStackView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()

    let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .ehmRed
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let bandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .ehmGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let songsStackView: UIStackView = {
        let songsView = UIStackView()
        songsView.translatesAutoresizingMaskIntoConstraints = false
        return songsView
    }()

    let songsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()

    let songsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Список композиций"
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    let historyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let historyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "История"
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    let historyTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()

    var dynamicViews: [UIView]?

    let albumTypeView: AdditionalInfoView = {
        return AdditionalInfoView(title: "Тип альбома")
    }()

    let releaseDateView: AdditionalInfoView = {
        return AdditionalInfoView(title: "Дата выхода")
    }()

    let genresView: AdditionalInfoView = {
        return AdditionalInfoView(title: "Жанры")
    }()

    init(albumId: Int, title: String) {
        self.albumId = albumId
        self.navigationTitle = title
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        dynamicViews = [titleLabel, bandLabel, historyTextLabel]

        setupViews()

        albumDataProvider = DataProvider<Album, AlbumViewModelItem>(delegate: self)
        albumDataProvider?.requestDataFor(id: albumId)

        alertPresenter = AlertPresenter(delegate: self)
        pdfService = PDFService(
            delegate: self,
            title: navigationTitle,
            view: albumScrollView,
            type: Album.self
        )

        songsTableView.dataSource = self
        songsTableView.register(SongsTableCell.self, forCellReuseIdentifier: "SongsTableCell")
        songsTableView.isScrollEnabled = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pdfService?.removePDF()
    }

    private func setupViews() {
        setupNavigation()
        setupScrollView()
        setupHeader()
        setupSongs()
        setupHistory()
        setupAdditionalInfo()
    }

    func present(album: AlbumViewModelItem) {
        titleLabel.text = album.title
        bandLabel.text = album.band
        historyTextLabel.text = album.history
        albumTypeView.set(info: album.albumType)
        genresView.set(info: album.genres)
        releaseDateView.set(info: album.released)
        albumCoverImageView.image = album.cover

        let labels = [titleLabel, bandLabel, historyTextLabel]

        size(labels: labels)
    }

    private func setupNavigation() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = navigationTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(requestSharePDF)
        )
        navigationController?.navigationBar.tintColor = .ehmRed
    }
}

extension AlbumViewController: AlertPresenterDelegate {
    func didRecieveAlert(alert: UIAlertController) {
        present(alert, animated: true)
    }

    func makeRequest() {
        albumDataProvider?.requestDataFor(id: albumId)
    }
}

extension AlbumViewController: PDFServiceDelegate {
    func presentPDFActivityController(vc: UIViewController) {
        present(vc, animated: true)
    }

    func fixConstraints() {
        albumScrollView.makeStandardConstraints()
    }

    @objc
    private func requestSharePDF() {
        pdfService?.sharePDF()
    }
}
