//
//  MainTabBarController.swift
//  EHM
//
//  Created by Александр Бекренев on 09.11.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
        setupVCs()
    }
    
    private func setupVCs() {
        viewControllers = [ createSearchViewController(), createProfileViewController() ]
    }
    
    private func createSearchViewController() -> UINavigationController {
        let searchVC = UINavigationController(rootViewController: SearchViewController())
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
    
    private func setupTabbar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .ehmBlack
        setTabBarItemColors(appearance.stackedLayoutAppearance)
        tabBar.scrollEdgeAppearance = appearance
    }
    
    private func setTabBarItemColors(_ itemAppearance: UITabBarItemAppearance) {
        itemAppearance.selected.iconColor = .ehmRed
        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.ehmRed]
    }
}
