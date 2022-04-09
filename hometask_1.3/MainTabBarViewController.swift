//
//  MainTabBarViewController.swift
//  hometask_1.3
//
//  Created by Юрий Демиденко on 09.04.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    let feedVC = FeedViewController()
    let profileVC = ProfileViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }

    private func setupControllers() {
        feedVC.tabBarItem.title = "Лента"
        feedVC.tabBarItem.image = UIImage(systemName: "film")
        feedVC.navigationItem.title = "Лента"
        let feedNavigationController = UINavigationController(rootViewController: feedVC)

        profileVC.tabBarItem.title = "Профиль"
        profileVC.tabBarItem.image = UIImage(systemName: "folder.fill.badge.person.crop")
        profileVC.navigationItem.title = "Профиль"
        let profileNavigationController = UINavigationController(rootViewController: profileVC)

        viewControllers = [feedNavigationController, profileNavigationController]
    }

}
