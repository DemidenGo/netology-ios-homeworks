//
//  MainTabBarViewController.swift
//  hometask_1.3
//
//  Created by Юрий Демиденко on 09.04.2022.
//

import UIKit

final class MainTabBarViewController: UITabBarController {

    private let feedVC = FeedViewController()
    private let profileVC = LogInViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }

    private func setupControllers() {

        feedVC.tabBarItem.title = "Feed"
        feedVC.tabBarItem.image = UIImage(systemName: "film")
        feedVC.navigationItem.title = "Feed"
        feedVC.navigationItem.backButtonTitle = "Back"
        let feedNavController = UINavigationController(rootViewController: feedVC)

        profileVC.tabBarItem.title = "Profile"
        profileVC.tabBarItem.image = UIImage(systemName: "folder.fill.badge.person.crop")
        profileVC.navigationItem.title = "Profile"
        profileVC.navigationItem.backButtonTitle = "Back"
        let profileNavController = UINavigationController(rootViewController: profileVC)
        profileNavController.navigationBar.isHidden = true

        tabBar.backgroundColor = .white
        viewControllers = [feedNavController, profileNavController]

    }
}
