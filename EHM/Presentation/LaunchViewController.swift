//
//  LaunchViewController.swift
//  EHM
//
//  Created by Александр Бекренев on 09.11.2022.
//

import Foundation
import UIKit

class LaunchViewController: UIViewController {
    private let firstLaunchService: FirstLaunchServiceProtocol = FirstLaunchService()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if firstLaunchService.isAppAlreadyLaunchedOnce() {
            let searchVC = UINavigationController(rootViewController: SearchViewController())
            searchVC.navigationBar.prefersLargeTitles = true
            searchVC.modalPresentationStyle = .fullScreen
            searchVC.modalTransitionStyle = .crossDissolve
            show(searchVC, sender: self)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let startVC = storyboard.instantiateViewController(withIdentifier: "StartViewController")
            startVC.modalPresentationStyle = .fullScreen
            startVC.modalTransitionStyle = .crossDissolve
            show(startVC, sender: self)
        }
    }
}
