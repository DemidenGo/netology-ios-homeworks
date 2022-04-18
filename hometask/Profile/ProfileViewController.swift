//
//  ProfileViewController.swift
//  hometask
//
//  Created by Юрий Демиденко on 14.04.2022.
//

import UIKit

final class ProfileViewController: UIViewController {

    let profileHeaderView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        profileHeaderView.addCustomSubviews()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileHeaderView.frame = view.frame
    }

    private func setupController() {

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

        view.backgroundColor = .lightGray
        view.addSubview(profileHeaderView)

    }

}
