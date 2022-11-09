//
//  StartViewController.swift
//  EHM
//
//  Created by Александр Бекренев on 08.11.2022.
//

import UIKit

class StartViewController: UIViewController {
    @IBOutlet private weak var hetfieldImageView: UIImageView!
    private let navigationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .ehmRed
        button.setTitle("Let's Rock!", for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupHetfieldImageView()
        setupNavigationButton()
    }
    
    private func setupHetfieldImageView() {
        let image = UIImage(named: "JH")?.image(alpha: 0.4)
        hetfieldImageView.image = image
    }
    
    private func setupNavigationButton() {
        view.addSubview(navigationButton)
        let constraints = [
            navigationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            navigationButton.widthAnchor.constraint(equalToConstant: 190),
            navigationButton.heightAnchor.constraint(equalToConstant: 60),
            navigationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -115)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

