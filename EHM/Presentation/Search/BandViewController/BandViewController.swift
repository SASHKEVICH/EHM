//
//  BandViewController.swift
//  EHM
//
//  Created by Александр Бекренев on 17.11.2022.
//

// TODO: Напрашивается наследование

import UIKit
import PDFGenerator

final class BandViewController: UIViewController {
    private let bandId: Int
    private let navigationTitle: String
    
    private var bandDataProvider: DataProvider<Band, BandViewModelItem>?
    private var pdfURL: URL?
    
    var albums: [AlbumViewModelItem]?
    var currentMembers: [MemberViewModelItem]?
    var previousMembers: [MemberViewModelItem]?
    
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
        stackView.distribution = .fill
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let bandImageView: UIImageView = {
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
    
    let discographyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
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

    let discographyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    let historyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
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
    
    let currentMembersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let currentMembersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.text = "Текущий состав"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let currentMembersTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    
    let originCityView: AdditionalInfoView = {
        return AdditionalInfoView(title: "Город основания")
    }()
    
    let yearsView: AdditionalInfoView = {
        return AdditionalInfoView(title: "Годы")
    }()
    
    let genresView: AdditionalInfoView = {
        return AdditionalInfoView(title: "Жанры")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        bandDataProvider = DataProvider(delegate: self)
        bandDataProvider?.requestDataFor(id: bandId)
        
        discographyCollectionView.dataSource = self
        discographyCollectionView.delegate = self
        discographyCollectionView.register(AlbumsCollectionViewCell.self, forCellWithReuseIdentifier: "AlbumsCollectionViewCell")
        
        for tableView in [currentMembersTableView] {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(MemberTableViewCell.self, forCellReuseIdentifier: "MemberTableViewCell")
        }
        
        setupViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let pdfURL = pdfURL else { return }
        let fileManager = FileManager()
        do {
            try fileManager.removeItem(at: pdfURL)
        } catch {
            print(error)
        }
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
        setupHeader()
        setupDiscography()
        setupHistory()
        setupCurrentMembers()
        setupAdditionalInfo()
    }
    
    func present(band: BandViewModelItem) {
        historyTextLabel.text = band.history
        titleLabel.text = navigationTitle
        originCityView.set(info: band.origin)
        yearsView.set(info: band.years)
        genresView.set(info: band.genres)
        bandImageView.image = band.cover
        
        size(labels: [historyTextLabel, titleLabel])
    }
    
    private func setupNavigation() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = navigationTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePDF))
        navigationController?.navigationBar.tintColor = .ehmRed
    }
    
    @objc func sharePDF() {
        generatePDF()
        if
            let pdfURL = pdfURL,
            let pdfData = NSData(contentsOf: (pdfURL)) {
            let activityViewController = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        }
    }
    
    private func generatePDF() {
        let view = bandScrollView
        view.backgroundColor = .black
        
        let dashedTitle = navigationTitle.split(separator: " ").joined(separator: "-")
        pdfURL = URL(fileURLWithPath: NSTemporaryDirectory().appending("\(dashedTitle)-band.pdf"))
        do {
            guard let pdfURL = pdfURL else { return }
            try PDFGenerator.generate([view], to: pdfURL)
        } catch (let error) {
            print(error)
        }
        bandScrollView.makeStandardConstraints()
    }
}
