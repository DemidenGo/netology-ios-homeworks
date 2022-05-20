//
//  ProfileHeaderView.swift
//  hometask
//
//  Created by Юрий Демиденко on 14.04.2022.
//

import UIKit

final class ProfileHeaderView: UIView {

    private var profileImageViewWidthConstraint = NSLayoutConstraint()
    private var profileImageViewHeightConstraint = NSLayoutConstraint()
    private var profileImageViewCenterXConstraint = NSLayoutConstraint()
    private var profileImageViewCenterYConstraint = NSLayoutConstraint()


    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemBlue
        imageView.image = UIImage(named: "homer")
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()

    private lazy var profileNameLabel: UILabel = {
        let profileLabel = UILabel()
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        profileLabel.text = "Homer Simpson"
        profileLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        profileLabel.textColor = .black
        return profileLabel
    }()

    private lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.text = "Woo-Hoo!"
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = .gray
        return statusLabel
    }()

    private lazy var setStatusButton: UIButton = {
        let statusButton = UIButton()
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        statusButton.backgroundColor = .systemBlue
        statusButton.setTitleColor(.white, for: .normal)
        statusButton.setTitle("Set status", for: .normal)
        statusButton.layer.cornerRadius = 4
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowRadius = 4
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOpacity = 0.7
        statusButton.addTarget(self, action: #selector(statusButtonAction), for: .touchUpInside)
        return statusButton
    }()

    private var statusText: String?

    @objc private func statusButtonAction() {
        guard statusText != nil && statusText != "" else { return }
        statusLabel.text = statusText
    }

    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter your status here"
        textField.makeIndent(points: 10)
        textField.clearButtonMode = .whileEditing
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12
        textField.addTarget(self, action: #selector(statusTextFieldDidChange), for: .editingChanged)
        textField.delegate = self
        return textField
    }()

    @objc private func statusTextFieldDidChange() {
        statusText = statusTextField.text
    }

    private lazy var largeAvatarBackground: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .black
        view.alpha = 0.0
        return view
    }()

    @objc private func tapGestureAction() {

        largeAvatarViewLayout()

        UIView.animateKeyframes(withDuration: 0.8, delay: 0.0) {

            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.625) {
                self.profileImageViewWidthConstraint.constant = UIScreen.main.bounds.width
                self.profileImageViewHeightConstraint.constant = self.profileImageView.bounds.height * (UIScreen.main.bounds.width / self.profileImageView.bounds.width)
                self.profileImageViewCenterXConstraint.constant = UIScreen.main.bounds.width / 2
                self.profileImageViewCenterYConstraint.constant = UIScreen.main.bounds.height / 2 - 25
                self.layoutIfNeeded()
            }

            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.625) {
                self.largeAvatarBackground.alpha = 0.7
            }

            UIView.addKeyframe(withRelativeStartTime: 0.625, relativeDuration: 0.375) {
                self.closeButton.alpha = 1.0
            }
        }
    }

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
                self.largeAvatarBackground.alpha = 0.0
            }

            UIView.addKeyframe(withRelativeStartTime: 0.375, relativeDuration: 0.625) {
                self.profileImageViewWidthConstraint.constant = 120
                self.profileImageViewHeightConstraint.constant = 120
                self.profileImageViewCenterXConstraint.constant = 76
                self.profileImageViewCenterYConstraint.constant = 76
                self.layoutIfNeeded()
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.makeRounded()
    }

    private func largeAvatarViewLayout() {

        largeAvatarBackground.addSubview(closeButton)
        self.addSubview(largeAvatarBackground)
        self.bringSubviewToFront(profileImageView)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: largeAvatarBackground.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: largeAvatarBackground.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }

    func layout() {

        [profileImageView, profileNameLabel, statusLabel, setStatusButton, statusTextField].forEach { self.addSubview($0) }

        profileImageViewCenterXConstraint = profileImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 76)
        profileImageViewCenterYConstraint = profileImageView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 76)
        profileImageViewWidthConstraint = profileImageView.widthAnchor.constraint(equalToConstant: 120)
        profileImageViewHeightConstraint = profileImageView.heightAnchor.constraint(equalToConstant: 120)


        NSLayoutConstraint.activate([

            profileImageViewCenterXConstraint,
            profileImageViewCenterYConstraint,
            profileImageViewWidthConstraint,
            profileImageViewHeightConstraint,

            profileNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            profileNameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 156),
            profileNameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            profileNameLabel.heightAnchor.constraint(equalToConstant: 20),

            statusLabel.topAnchor.constraint(equalTo: profileNameLabel.bottomAnchor, constant: 50),
            statusLabel.leadingAnchor.constraint(equalTo: profileNameLabel.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            statusLabel.heightAnchor.constraint(equalToConstant: 16),

            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 8),
            statusTextField.leadingAnchor.constraint(equalTo: profileNameLabel.leadingAnchor),
            statusTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),

            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

//MARK: - UITextFieldDelegate

extension ProfileHeaderView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
}
