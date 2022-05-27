//
//  PhotosViewController.swift
//  hometask
//
//  Created by Юрий Демиденко on 05.05.2022.
//

import UIKit

class PhotosViewController: UIViewController {

    private let photosGalleryModel: [PhotosGalleryModel] = PhotosGalleryModel.makeMockModel()

    private lazy var smallImageFrame = CGRect()

    private var topBarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) + (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }

    private lazy var galleryPhotosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return collectionView
    }()

    private lazy var largePhotoBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.0)
        return view
    }()

    private lazy var largeImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.alpha = 0.0
        button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        return button
    }()

    @objc private func closeButtonAction() {

        UIView.animateKeyframes(withDuration: 0.8, delay: 0.0) {

            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.375) {
                self.closeButton.alpha = 0.0
            }

            UIView.addKeyframe(withRelativeStartTime: 0.375, relativeDuration: 0.625) {
                self.largePhotoBackground.backgroundColor = .black.withAlphaComponent(0.0)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.375, relativeDuration: 0.625) {
                self.largeImageView.frame = self.smallImageFrame
            }
        } completion: { _ in
            self.largePhotoBackground.removeFromSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        layout()
    }

    private func setupController() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        self.title = "Photo Gallery"
    }

    private func layout() {
        view.addSubview(galleryPhotosCollectionView)

        NSLayoutConstraint.activate([
            galleryPhotosCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            galleryPhotosCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            galleryPhotosCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            galleryPhotosCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    private func largePhotoViewLayout() {

        [largeImageView, closeButton].forEach { largePhotoBackground.addSubview($0) }
        view.addSubview(largePhotoBackground)

        NSLayoutConstraint.activate([
            largePhotoBackground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            largePhotoBackground.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            largePhotoBackground.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            largePhotoBackground.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            closeButton.topAnchor.constraint(equalTo: largePhotoBackground.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: largePhotoBackground.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
}

//MARK: - UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return photosGalleryModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setupCell(photosGalleryModel[indexPath.item])
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {

    private var inset: CGFloat { return 8 }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let itemSize = (UIScreen.main.bounds.width - inset * 4) / 3
        return CGSize(width: itemSize, height: itemSize)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return inset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return inset
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        var selectedItemLayout = UICollectionViewLayoutAttributes()

        largePhotoViewLayout()
        largeImageView.image = UIImage(named: photosGalleryModel[indexPath.item].image)

        if let itemLayout = collectionView.layoutAttributesForItem(at: indexPath) {
            selectedItemLayout = itemLayout
            smallImageFrame = CGRect(x: selectedItemLayout.frame.origin.x,
                                     y: selectedItemLayout.frame.origin.y - collectionView.bounds.origin.y,
                                     width: selectedItemLayout.size.width,
                                     height: selectedItemLayout.size.height)
            largeImageView.frame = smallImageFrame
        }

        UIView.animateKeyframes(withDuration: 0.8, delay: 0.0) {

            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.625) {
                self.largeImageView.frame.size.width = self.view.safeAreaLayoutGuide.layoutFrame.width
                self.largeImageView.frame.size.height = selectedItemLayout.size.height * (self.view.safeAreaLayoutGuide.layoutFrame.width / selectedItemLayout.size.width)
                self.largeImageView.center.x = UIScreen.main.bounds.midX
                self.largeImageView.center.y = UIScreen.main.bounds.midY - self.topBarHeight
            }

            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.625) {
                self.largePhotoBackground.backgroundColor = .black.withAlphaComponent(0.7)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.625, relativeDuration: 0.375) {
                self.closeButton.alpha = 1.0
            }
        }
    }
}
