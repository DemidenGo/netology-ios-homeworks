//
//  PostTableViewCell.swift
//  hometask
//
//  Created by Юрий Демиденко on 26.04.2022.
//

import UIKit

final class PostTableViewCell: UITableViewCell {

    var likesCount: Int = 0
    var viewsCount: Int = 0

    private lazy var backgroundCellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private lazy var postTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()

    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()

    private lazy var postLikesLabel: UILabel = {
        let label = UILabel()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(likesLabelTapAction))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
        return label
    }()

    @objc private func likesLabelTapAction() {
        likesCount += 1
        postLikesLabel.text = "Likes: " + String(likesCount)
    }

    private lazy var postViewsLabel: UILabel = {
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
        likesCount = model.likes
        viewsCount = model.views
        postLikesLabel.text = "Likes: " + String(likesCount)
        postViewsLabel.text = "Views: " + String(viewsCount)
    }

    func postViewsIncrement() {
        viewsCount += 1
        postViewsLabel.text = "Views: " + String(viewsCount)
    }

    private func layout() {
        [backgroundCellView, postTitleLabel, postImageView, postDescriptionLabel, postLikesLabel, postViewsLabel].forEach { contentView.addSubview($0) }

        let inset: CGFloat = 16

        NSLayoutConstraint.activate([
            backgroundCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            backgroundCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            backgroundCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            backgroundCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),

            postTitleLabel.topAnchor.constraint(equalTo: backgroundCellView.topAnchor),
            postTitleLabel.leadingAnchor.constraint(equalTo: backgroundCellView.leadingAnchor),
            postTitleLabel.trailingAnchor.constraint(equalTo: backgroundCellView.trailingAnchor),

            postImageView.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: 12),
            postImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            postImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),

            postDescriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: inset),
            postDescriptionLabel.leadingAnchor.constraint(equalTo: backgroundCellView.leadingAnchor, constant: inset),
            postDescriptionLabel.trailingAnchor.constraint(equalTo: backgroundCellView.trailingAnchor, constant: -inset),

            postLikesLabel.topAnchor.constraint(equalTo: postDescriptionLabel.bottomAnchor, constant: inset),
            postLikesLabel.leadingAnchor.constraint(equalTo: backgroundCellView.leadingAnchor, constant: inset),
            postLikesLabel.bottomAnchor.constraint(equalTo: backgroundCellView.bottomAnchor),
            postLikesLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),

            postViewsLabel.topAnchor.constraint(equalTo: postDescriptionLabel.bottomAnchor, constant: inset),
            postViewsLabel.bottomAnchor.constraint(equalTo: backgroundCellView.bottomAnchor),
            postViewsLabel.trailingAnchor.constraint(equalTo: backgroundCellView.trailingAnchor, constant: -inset),
            postViewsLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2)
        ])
    }
}
