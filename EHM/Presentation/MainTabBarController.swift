//
//  MainTabBarController.swift
//  EHM
//
//  Created by Александр Бекренев on 09.11.2022.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .ehmRed
        setupVCs()
    }
    
    private func setupVCs() {
        viewControllers = [ createSearchViewController(), createProfileViewController() ]
    }
    
    private func createSearchViewController() -> UINavigationController {
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        searchVC.navigationBar.barTintColor = .white
        searchVC.navigationBar.prefersLargeTitles = true
        searchVC.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Поиск", comment: ""),
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass"))
        return searchVC
    }
    
    private func createProfileViewController() -> UINavigationController {
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.navigationBar.prefersLargeTitles = true
        profileVC.navigationBar.barTintColor = .white
        profileVC.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Профиль", comment: ""),
            image: UIImage(systemName: "person.crop.circle"),
            selectedImage: UIImage(systemName: "person.crop.circle"))
        return profileVC
    }
}
