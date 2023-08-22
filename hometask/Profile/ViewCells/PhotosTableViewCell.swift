//
//  PhotosTableViewCell.swift
//  hometask
//
//  Created by Юрий Демиденко on 03.05.2022.
//

import UIKit

final class PhotosTableViewCell: UITableViewCell {

    weak var delegate: ViewShowable?

    private let photosGalleryModel: [PhotosGalleryModel] = PhotosGalleryModel.makeMockModel()

    private lazy var backgroundCellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private lazy var photosLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.text = "Photos"
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    private lazy var arrowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        let arrowConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .regular, scale: .large)
        let largeArrow = UIImage(systemName: "arrow.right", withConfiguration: arrowConfig)
        button.setImage(largeArrow?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.setImage(largeArrow?.withTintColor(UIColor(named: "customColor")!, renderingMode: .alwaysOriginal), for: .selected)
        button.setImage(largeArrow?.withTintColor(UIColor(named: "customColor")!, renderingMode: .alwaysOriginal), for: .highlighted)
        button.setImage(largeArrow?.withTintColor(UIColor(named: "customColor")!, renderingMode: .alwaysOriginal), for: .disabled)
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        return button
    }()

    private lazy var previewPhotosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func tapAction() {
        let photosVC = PhotosViewController()
        delegate?.show(photosVC)
    }

    private func layout() {
        [backgroundCellView, photosLabel, arrowButton, previewPhotosCollectionView].forEach { contentView.addSubview($0) }

        let inset: CGFloat = 12
        let interitemInset: CGFloat = 8

        NSLayoutConstraint.activate([
            backgroundCellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            photosLabel.topAnchor.constraint(equalTo: backgroundCellView.topAnchor, constant: inset),
            photosLabel.leadingAnchor.constraint(equalTo: backgroundCellView.leadingAnchor, constant: inset),

            arrowButton.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            arrowButton.trailingAnchor.constraint(equalTo: backgroundCellView.trailingAnchor, constant: -inset),

            previewPhotosCollectionView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: inset),
            previewPhotosCollectionView.leadingAnchor.constraint(equalTo: backgroundCellView.leadingAnchor, constant: inset),
            previewPhotosCollectionView.bottomAnchor.constraint(equalTo: backgroundCellView.bottomAnchor, constant: -inset),
            previewPhotosCollectionView.trailingAnchor.constraint(equalTo: backgroundCellView.trailingAnchor, constant: -inset),
            previewPhotosCollectionView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - (interitemInset * 3 + inset * 2)) / 4)
        ])
    }
}

//MARK: - UICollectionViewDataSource

extension PhotosTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photosGalleryModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.imageView.layer.cornerRadius = 6
        cell.setupCell(photosGalleryModel[indexPath.item])
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {

    private var inset: CGFloat { return 12 }
    private var interitemInset: CGFloat { return 8 }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let imageSize = (UIScreen.main.bounds.width - (interitemInset * 3 + inset * 2)) / 4
        return CGSize(width: imageSize, height: imageSize)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return interitemInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return interitemInset
    }
}
