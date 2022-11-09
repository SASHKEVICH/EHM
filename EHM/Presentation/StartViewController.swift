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
        navigationButton.addTarget(self, action: #selector(presentMainViewController), for: .touchUpInside)
        navigationButton.addTarget(self, action: #selector(changeBackgroundColorForButton), for: .touchDown)
        navigationButton.addTarget(self, action: #selector(restoreBackgroundColorForButton), for: .touchDragOutside)
        let constraints = [
            navigationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            navigationButton.widthAnchor.constraint(equalToConstant: 190),
            navigationButton.heightAnchor.constraint(equalToConstant: 60),
            navigationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -115)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func presentMainViewController() {
        let mainVC = MainTabBarController()
        mainVC.modalPresentationStyle = .fullScreen
        mainVC.modalTransitionStyle = .crossDissolve
        present(mainVC, animated: true)
    }
    
    @objc private func changeBackgroundColorForButton() {
        animateChangingColor(duration: 0.05, color: .ehmDarkRed)
    }
    
    @objc private func restoreBackgroundColorForButton() {
        animateChangingColor(duration: 0.15, color: .ehmRed)
    }
    
    private func animateChangingColor(duration: TimeInterval, color: UIColor) {
        UIView.animate(withDuration: duration, animations: {
            self.navigationButton.backgroundColor = color
        }, completion: nil)
    }
}

