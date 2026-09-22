//
//  ViewController.swift
//  ImageFeed
//
//  Created by Daniil Sivachenko on 05.09.2026.
//

import UIKit

final class ImagesListViewController: UIViewController {
    
    // MARK: - UI Elements
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Data
    
    // Название фотографий
    private let photoNames: [String] = Array(0..<20).map { "\($0)" }
    
    // Форматирование даты для подписи фотографии
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets(
            top: 12,
            left: 0,
            bottom: 12,
            right: 0
        )
    }
    
    // MARK: - Cell Configuration
    
    private func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        let photoName = photoNames[indexPath.row]
        guard let image = UIImage(named: photoName) else {
            return
        }
        cell.configureImage(image)
        
        let dateText = dateFormatter.string(from: Date())
        cell.configureDate(dateText)
        
        cell.configureLike(indexPath.row % 2 == 0)
    }
}

// MARK: - UITableViewDataSource

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        
        configCell(for: imageListCell, with: indexPath)
        return imageListCell
    }
}

// MARK: - UITableViewDelegate

extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {

        guard let image = UIImage(named: photoNames[indexPath.row]) else {
            return 200
        }
        
        let imageWidth = image.size.width
        let imageHeight = image.size.height
    
        let horizontalInset: CGFloat = 16
        let verticalInset: CGFloat = 4
        
        let imageViewWidth = tableView.bounds.width - horizontalInset * 2
        
        let imageViewHeight = imageViewWidth * imageHeight / imageWidth
        
        return imageViewHeight + verticalInset * 2
    }
}
