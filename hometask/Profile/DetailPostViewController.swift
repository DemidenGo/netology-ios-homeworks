//
//  DetailPostViewController.swift
//  hometask
//
//  Created by Юрий Демиденко on 23.05.2022.
//

import UIKit

class DetailPostViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var postTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var postDetailDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    func setupVC(model: PostModel) {
        postTitleLabel.text = model.author + ": " + model.title
        postImageView.image = UIImage(named: model.image)
        postDetailDescriptionLabel.text = model.detailDescription
    }

    private func layout() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [postTitleLabel, postImageView, postDetailDescriptionLabel].forEach { contentView.addSubview($0) }

        let inset: CGFloat = 16

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            postTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            postTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            postTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),

            postImageView.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: inset),
            postImageView.leadingAnchor.constraint(equalTo: postTitleLabel.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: postTitleLabel.trailingAnchor),

            postDetailDescriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: inset),
            postDetailDescriptionLabel.leadingAnchor.constraint(equalTo: postImageView.leadingAnchor),
            postDetailDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            postDetailDescriptionLabel.trailingAnchor.constraint(equalTo: postImageView.trailingAnchor)
        ])
    }
}
