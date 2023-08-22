//
//  LogInViewController.swift
//  hometask
//
//  Created by Юрий Демиденко on 23.04.2022.
//

import UIKit

final class LogInViewController: UIViewController {

    private let defaultLogin: String = "user"
    private let defaultPassword: String = "12345678"

    private let notificationCenter = NotificationCenter.default

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delaysContentTouches = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        return imageView
    }()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.placeholder = "Email or phone (enter \"user\")"
        textField.clearButtonMode = .whileEditing
        textField.makeIndent(points: 12)
        textField.delegate = self
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.placeholder = "Password (enter \"12345678\")"
        textField.clearButtonMode = .whileEditing
        textField.makeIndent(points: 12)
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()

    private lazy var logInButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "blue_pixel")
        let alpha: CGFloat = 0.8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.setBackgroundImage(image, for: .normal)
        button.setBackgroundImage(image?.withAlpha(alpha), for: .selected)
        button.setBackgroundImage(image?.withAlpha(alpha), for: .highlighted)
        button.setBackgroundImage(image?.withAlpha(alpha), for: .disabled)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        return button
    }()

    @objc private func tapAction() {
        guard emailTextField.text != "" else {
            emailTextField.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.2)
            emailTextField.shake()
            return
        }
        guard passwordTextField.text != "" && passwordTextField.text != nil else {
            passwordTextField.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.2)
            passwordTextField.shake()
            return
        }
        guard passwordTextField.text!.count > 4 else {
            if contentView.subviews.contains(shortPasswordLabel) {
                shortPasswordLabel.isHidden = false
            } else {
                shortPasswordLabelLayout()
            }
            return
        }
        guard emailTextField.text == defaultLogin && passwordTextField.text == defaultPassword else {
            let alert = UIAlertController(title: "Wrong login or password", message: "Use default values: login - user, password - 12345678", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                self.emailTextField.text = self.defaultLogin
                self.passwordTextField.text = self.defaultPassword
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            present(alert, animated: true)
            return
        }
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }

    private lazy var shortPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Password field needs more than 4 symbols"
        label.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc private func keyboardWillHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }

    private func layout() {

        view.backgroundColor = .white
    
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [imageView, emailTextField, passwordTextField, logInButton].forEach { contentView.addSubview($0) }

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

            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),

            emailTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 120),
            emailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            logInButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            logInButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func shortPasswordLabelLayout() {
        contentView.addSubview(shortPasswordLabel)

        NSLayoutConstraint.activate([
            shortPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 7),
            shortPasswordLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            shortPasswordLabel.bottomAnchor.constraint(equalTo: logInButton.topAnchor, constant: -7),
            shortPasswordLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor)
        ])
    }
}

//MARK: - UITextFieldDelegate

extension LogInViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        emailTextField.backgroundColor = .systemGray6
        passwordTextField.backgroundColor = .systemGray6
        if contentView.subviews.contains(shortPasswordLabel) {
            shortPasswordLabel.isHidden = true
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        emailTextField.backgroundColor = .systemGray6
        passwordTextField.backgroundColor = .systemGray6
        if contentView.subviews.contains(shortPasswordLabel) {
            shortPasswordLabel.isHidden = true
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        emailTextField.backgroundColor = .systemGray6
        passwordTextField.backgroundColor = .systemGray6
        if contentView.subviews.contains(shortPasswordLabel) {
            shortPasswordLabel.isHidden = true
        }
    }
}
