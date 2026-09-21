//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Daniil Sivachenko on 21.09.2026.
//

import UIKit

// MARK: - ImagesListCell

final class ImagesListCell: UITableViewCell {
    
    static let reuseIdentifier = "ImagesListCell"
    
    // MARK: - UI Elements
    
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var photoImageView: UIImageView!
    @IBOutlet private var likeButton: UIButton!
    
    // MARK: - Configuration
    
    // Устанавливаем фотографию в ячейку
    func configureImage(_ image: UIImage) {
        photoImageView.image = image
    }
    
    // Настраиваем дату
    func configureDate(_ date: String) {
        dateLabel.text = date
    }
    
    // Настраиваем состояние лайка
    func configureLike(_ isLiked: Bool) {
        if isLiked {
            likeButton.setImage(UIImage(named: "Active"), for: .normal)
        } else {
            likeButton.setImage(UIImage(named: "No Active"), for: .normal)
        }
    }
}
