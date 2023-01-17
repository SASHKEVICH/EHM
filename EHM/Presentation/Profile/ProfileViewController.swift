//
//  ProfileViewController.swift
//  EHM
//
//  Created by Александр Бекренев on 09.11.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Профиль"
        label.textColor = .white
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Профиль"
        view.backgroundColor = .ehmBlack
        view.addSubview(profileLabel)
        
        let constraints = [
            profileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
