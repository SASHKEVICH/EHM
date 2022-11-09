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
        let searchVC = SearchViewController()
        searchVC.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Поиск", comment: ""),
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass"))
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Профиль", comment: ""),
            image: UIImage(systemName: "person.crop.circle"),
            selectedImage: UIImage(systemName: "person.crop.circle"))
        
        viewControllers = [ searchVC, profileVC ]
    }
}
