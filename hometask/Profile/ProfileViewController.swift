//
//  ProfileViewController.swift
//  hometask
//
//  Created by Юрий Демиденко on 14.04.2022.
//

import UIKit

final class ProfileViewController: UIViewController {

    private let profileHeaderView = ProfileHeaderView()

    private let newButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("New button", for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupController()
        profileHeaderView.layout()
    }

    private func setupController() {

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = .lightGray

        [profileHeaderView, newButton].forEach { self.view.addSubview($0) }

        NSLayoutConstraint.activate([
            profileHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 245)
        ])

        NSLayoutConstraint.activate([
            newButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            newButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            newButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
