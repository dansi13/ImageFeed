//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Daniil Sivachenko on 23.09.2026.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var profileImageView = UIImageView()
    private lazy var userNameLabel = UILabel()
    private lazy var userIdLabel = UILabel()
    private lazy var descriptionLabel = UILabel()
    private lazy var logoutButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProfileImageView()
        setupUserNameLabel()
        setupUserIdLabel()
        setupDescriptionLabel()
        setupLogoutButton()
    }
    
    // MARK: - Private Methods
    
    private func setupProfileImageView() {
        view.addSubview(profileImageView)
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = UIImage(resource: .profilePhoto)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),
            profileImageView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            profileImageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 32
            )
        ])
    }
    
    private func setupUserNameLabel() {
        view.addSubview(userNameLabel)
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.text = "Екатерина Новикова"
        userNameLabel.font = .systemFont(ofSize: 23, weight: .bold)
        userNameLabel.textColor = .ypWhite
        
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(
                equalTo: profileImageView.leadingAnchor
            ),
            userNameLabel.topAnchor.constraint(
                equalTo: profileImageView.bottomAnchor,
                constant: 8
            )
        ])
    }
    
    private func setupUserIdLabel() {
        view.addSubview(userIdLabel)
        
        userIdLabel.translatesAutoresizingMaskIntoConstraints = false
        userIdLabel.text = "@ekaterina_nov"
        userIdLabel.font = .systemFont(ofSize: 13)
        userIdLabel.textColor = .ypGray
        
        NSLayoutConstraint.activate([
            userIdLabel.leadingAnchor.constraint(
                equalTo: userNameLabel.leadingAnchor
            ),
            userIdLabel.topAnchor.constraint(
                equalTo: userNameLabel.bottomAnchor,
                constant: 8
            )
        ])
    }
    
    private func setupDescriptionLabel() {
        view.addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Hello, world!"
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.textColor = .ypWhite
        descriptionLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(
                equalTo: userNameLabel.leadingAnchor
            ),
            descriptionLabel.topAnchor.constraint(
                equalTo: userIdLabel.bottomAnchor,
                constant: 8
            ),
            descriptionLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            )
        ])
    }
    
    private func setupLogoutButton() {
        view.addSubview(logoutButton)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(resource: .logout)
            .withRenderingMode(.alwaysOriginal)
        
        logoutButton.setImage(image, for: .normal)
        
        logoutButton.addTarget(
            self,
            action: #selector(logoutButtonTapped),
            for: .touchUpInside
        )
        
        NSLayoutConstraint.activate([
            logoutButton.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -20
            ),
            logoutButton.centerYAnchor.constraint(
                equalTo: profileImageView.centerYAnchor
            )
        ])
    }
    
    @objc private func logoutButtonTapped() {
    }
}
