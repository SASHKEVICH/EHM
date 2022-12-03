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
    var currentMembers: [Member]?
    var previousMembers: [Member]?
    let itemsPerRow: CGFloat = 1
    
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
    
    let previousMembersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let previousMembersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.text = "Предыдущий состав"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let previousMembersTableView: UITableView = {
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
        
        bandDataProvider = BandDataProvider(delegate: self)
        bandDataProvider?.requestDataFor(id: bandId)
        
        discographyCollectionView.dataSource = self
        discographyCollectionView.delegate = self
        discographyCollectionView.register(AlbumsCollectionViewCell.self, forCellWithReuseIdentifier: "AlbumsCollectionViewCell")
        
        for tableView in [currentMembersTableView, previousMembersTableView] {
            tableView.dataSource = self
            tableView.register(MemberTableViewCell.self, forCellReuseIdentifier: "MemberTableViewCell")
        }
        
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
        setupHeader()
        setupDiscography()
        setupHistory()
        setupCurrentMembers()
        setupPreviousMembers()
        setupAdditionalInfo()
    }
    
    func present(band: Band) {
        historyTextLabel.text = band.history
        titleLabel.text = navigationTitle
        originCityView.set(info: band.origin)
        yearsView.set(info: band.getYearsRepresentation())
        genresView.set(info: band.getGenres())
        
        size(labels: [historyTextLabel, titleLabel])
    }
    
    private func setupNavigation() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = navigationTitle
        navigationController?.navigationBar.tintColor = .ehmRed
    }
}
