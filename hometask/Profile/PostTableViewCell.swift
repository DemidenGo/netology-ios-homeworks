//
//  PostTableViewCell.swift
//  hometask
//
//  Created by Юрий Демиденко on 26.04.2022.
//

import UIKit

final class PostTableViewCell: UITableViewCell {

    private let backgroundCellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private let postTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()

    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()

    private let postLikesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private let postViewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(_ model: PostModel) {
        postTitleLabel.text = model.author + ". " + model.title
        postImageView.image = UIImage(named: model.image)
        postDescriptionLabel.text = model.description
        postLikesLabel.text = "Likes: " + String(model.likes)
        postViewsLabel.text = "Views: " + String(model.views)
    }

    private func layout() {
        [backgroundCellView, postTitleLabel, postImageView, postDescriptionLabel, postLikesLabel, postViewsLabel].forEach { contentView.addSubview($0) }

        let inset: CGFloat = 16

        NSLayoutConstraint.activate([
            backgroundCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            backgroundCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            backgroundCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            backgroundCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])

        NSLayoutConstraint.activate([
            postTitleLabel.topAnchor.constraint(equalTo: backgroundCellView.topAnchor),
            postTitleLabel.leadingAnchor.constraint(equalTo: backgroundCellView.leadingAnchor),
            postTitleLabel.trailingAnchor.constraint(equalTo: backgroundCellView.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: 12),
            postImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            postImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])

        NSLayoutConstraint.activate([
            postDescriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: inset),
            postDescriptionLabel.leadingAnchor.constraint(equalTo: backgroundCellView.leadingAnchor, constant: inset),
            postDescriptionLabel.trailingAnchor.constraint(equalTo: backgroundCellView.trailingAnchor, constant: -inset)
        ])

        NSLayoutConstraint.activate([
            postLikesLabel.topAnchor.constraint(equalTo: postDescriptionLabel.bottomAnchor, constant: inset),
            postLikesLabel.leadingAnchor.constraint(equalTo: backgroundCellView.leadingAnchor, constant: inset),
            postLikesLabel.bottomAnchor.constraint(equalTo: backgroundCellView.bottomAnchor),
            postLikesLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2)
        ])

        NSLayoutConstraint.activate([
            postViewsLabel.topAnchor.constraint(equalTo: postDescriptionLabel.bottomAnchor, constant: inset),
            postViewsLabel.bottomAnchor.constraint(equalTo: backgroundCellView.bottomAnchor),
            postViewsLabel.trailingAnchor.constraint(equalTo: backgroundCellView.trailingAnchor, constant: -inset),
            postViewsLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2)
        ])
    }
}
