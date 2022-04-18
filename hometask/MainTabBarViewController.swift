//
//  MainTabBarViewController.swift
//  hometask_1.3
//
//  Created by Юрий Демиденко on 09.04.2022.
//

import UIKit

final class MainTabBarViewController: UITabBarController {

    let feedVC = FeedViewController()
    let profileVC = ProfileViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }

    private func setupControllers() {

        feedVC.tabBarItem.title = "Feed"
        feedVC.tabBarItem.image = UIImage(systemName: "film")
        feedVC.navigationItem.title = "Feed"
        feedVC.navigationItem.backButtonTitle = "Back"
        let feedNavigationController = UINavigationController(rootViewController: feedVC)

        profileVC.tabBarItem.title = "Profile"
        profileVC.tabBarItem.image = UIImage(systemName: "folder.fill.badge.person.crop")
        profileVC.navigationItem.title = "Profile"
        let profileNavigationController = UINavigationController(rootViewController: profileVC)

        tabBar.backgroundColor = .white
        viewControllers = [feedNavigationController, profileNavigationController]

    }

}
