//
//  FeedViewController.swift
//  hometask_1.3
//
//  Created by Юрий Демиденко on 09.04.2022.
//

import UIKit

final class FeedViewController: UIViewController {

    private lazy var feedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .systemGray
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    private lazy var firstButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("First button", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        return button
    }()

    private lazy var secondButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Second button", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        return button
    }()

    @objc private func tapAction() {
        let postVC = PostViewController()
        navigationController?.pushViewController(postVC, animated: true)
        let post = Post(title: "My post")
        postVC.post = post
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupController()
    }

    private func setupController() {

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

        self.view.backgroundColor = .systemGray

        self.view.addSubview(feedStackView)
        feedStackView.center = self.view.center
        [firstButton, secondButton].forEach { feedStackView.addArrangedSubview($0) }

        NSLayoutConstraint.activate([
            feedStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            feedStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            feedStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            feedStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
