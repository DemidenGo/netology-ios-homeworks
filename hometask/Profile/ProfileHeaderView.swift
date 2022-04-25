//
//  ProfileHeaderView.swift
//  hometask
//
//  Created by Юрий Демиденко on 14.04.2022.
//

import UIKit

final class ProfileHeaderView: UIView {

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemBlue
        imageView.image = UIImage(named: "homer")
        return imageView
    }()

    private let profileNameLabel: UILabel = {
        let profileLabel = UILabel()
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        profileLabel.text = "Homer Simpson"
        profileLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        profileLabel.textColor = .black
        return profileLabel
    }()

    private let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.text = "Woo-Hoo!"
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = .gray
        return statusLabel
    }()

    private let setStatusButton: UIButton = {
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
        statusButton.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        return statusButton
    }()

    @objc private func tapAction() {
        //print(statusLabel.text ?? "Status not set")
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
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.delegate = self
        return textField
    }()

    private var statusText: String?

    @objc private func textFieldDidChange() {
        statusText = statusTextField.text
    }

    func layout() {

        [profileImageView, profileNameLabel, statusLabel, setStatusButton, statusTextField].forEach { self.addSubview($0) }

        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
        profileImageView.makeRounded()

        NSLayoutConstraint.activate([
            profileNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            profileNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            profileNameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            profileNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: profileNameLabel.bottomAnchor, constant: 50),
            statusLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            statusLabel.heightAnchor.constraint(equalToConstant: 16)
        ])

        NSLayoutConstraint.activate([
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 8),
            statusTextField.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            statusTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40)
        ])

        NSLayoutConstraint.activate([
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension UIImageView {

    func makeRounded() {
        self.layoutIfNeeded()
        self.contentMode = .scaleAspectFit
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = true
    }
}

extension UITextField {

    func makeIndent(points: CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: points, height: self.frame.height))
        self.leftViewMode = .always
    }
}

//MARK: - UITextFieldDelegate

extension ProfileHeaderView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
}
