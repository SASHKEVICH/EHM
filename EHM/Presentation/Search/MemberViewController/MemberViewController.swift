//
//  MemberViewController.swift
//  EHM
//
//  Created by Александр Бекренев on 04.12.2022.
//

import UIKit

class MemberViewController: UIViewController {
    private let memberId: Int
    private let navigationTitle: String
    
    private var memberDataProvider: DataProviderProtocol?
    
    var bands: [Band]?
    
    let memberScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let memberStackView: UIStackView = {
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
    
    let memberImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .ehmRed
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let yearsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .ehmGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let biographyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let biographyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.text = "Биография"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let biographyTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let currentBandsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let currentBandsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.text = "Текущие группы"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let currentBandsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    
    let originCityView: AdditionalInfoView = {
        return AdditionalInfoView(title: "Родной город")
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        memberDataProvider = MemberDataProvider(delegate: self)
        memberDataProvider?.requestDataFor(id: memberId)
        
        currentBandsTableView.dataSource = self
        currentBandsTableView.delegate = self
        currentBandsTableView.register(BandsTableViewCell.self, forCellReuseIdentifier: "BandsTableViewCell")
        
        setupViews()
    }
    
    init(memberId: Int, title: String) {
        self.memberId = memberId
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
        setupBiography()
        setupCurrentBands()
        setupAdditionalInfo()
    }
    
    func present(member: Member) {
        nameLabel.text = member.name
        yearsLabel.text = member.getYears()
        originCityView.set(info: member.origin)
        biographyTextLabel.text = member.biography
        
        size(labels: [nameLabel, yearsLabel, biographyTextLabel])
    }
    
    private func setupNavigation() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = navigationTitle
        navigationController?.navigationBar.tintColor = .ehmRed
    }
}
