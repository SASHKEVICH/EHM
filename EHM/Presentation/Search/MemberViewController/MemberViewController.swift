//
//  MemberViewController.swift
//  EHM
//
//  Created by Александр Бекренев on 04.12.2022.
//

import UIKit
import PDFGenerator

final class MemberViewController: UIViewController {
    private let memberId: Int
    private let navigationTitle: String
    
    private var memberDataProvider: DataProviderProtocol?
    private var pdfURL: URL?
    
    var bands: [BandViewModelItem]?
    
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
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
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
        
        memberDataProvider = DataProvider<Member, MemberViewModelItem>(delegate: self)
        memberDataProvider?.requestDataFor(id: memberId)
        
        currentBandsTableView.dataSource = self
        currentBandsTableView.delegate = self
        currentBandsTableView.register(BandsTableViewCell.self, forCellReuseIdentifier: "BandsTableViewCell")
        
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
    
    func present(member: MemberViewModelItem) {
        nameLabel.text = member.title
        yearsLabel.text = member.years
        originCityView.set(info: member.origin)
        biographyTextLabel.text = member.biography
        memberImageView.image = member.cover
        
        size(labels: [nameLabel, yearsLabel, biographyTextLabel])
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
    
    private func generatePDF(){
        let view = memberScrollView
        view.backgroundColor = .black
        
        let dashedTitle = navigationTitle.split(separator: " ").joined(separator: "-")
        pdfURL = URL(fileURLWithPath: NSTemporaryDirectory().appending("\(dashedTitle)-member.pdf"))
        do {
            guard let pdfURL = pdfURL else { return }
            try PDFGenerator.generate([view], to: pdfURL)
        } catch (let error) {
            print(error)
        }
        memberScrollView.makeStandardConstraints()
    }
}
