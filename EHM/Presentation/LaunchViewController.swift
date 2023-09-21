//
//  LaunchViewController.swift
//  EHM
//
//  Created by Александр Бекренев on 09.11.2022.
//

import UIKit

final class LaunchViewController: UIViewController {
    private let firstLaunchService = FirstLaunchService()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if firstLaunchService.isAppAlreadyLaunchedOnce() {
            let mainVC = MainTabBarController()
            mainVC.modalPresentationStyle = .fullScreen
            mainVC.modalTransitionStyle = .crossDissolve
            show(mainVC, sender: self)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let startVC = storyboard.instantiateViewController(withIdentifier: "StartViewController")
            startVC.modalPresentationStyle = .fullScreen
            startVC.modalTransitionStyle = .crossDissolve
            show(startVC, sender: self)
        }
    }
}
