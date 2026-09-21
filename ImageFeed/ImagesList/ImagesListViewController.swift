//
//  ViewController.swift
//  ImageFeed
//
//  Created by Daniil Sivachenko on 05.09.2026.
//

import UIKit

class ImagesListViewController: UIViewController {
    
    // MARK: - UI Elements
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Data
    
    // Название фотографий
    private let photosName: [String] = Array(0..<20).map { "\($0)" }
    
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
        
        tableView.rowHeight = 200
        
        tableView.contentInset = UIEdgeInsets(
            top: 12,
            left: 0,
            bottom: 12,
            right: 0
        )
    }
    
    // MARK: - Cell Configuration
    
    private func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        let photoName = photosName[indexPath.row]
        guard let image = UIImage(named: photoName) else {
            return
        }
        cell.configureImage(image)
        
        let dateText = dateFormatter.string(from: Date())
        cell.configureDate(dateText)
        
        if indexPath.row % 2 == 0 {
            cell.configureLike(true)
        } else {
            cell.configureLike(false)
        }
    }
}

// MARK: - UITableViewDataSource

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosName.count
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = UIImage(named: photosName[indexPath.row]),
              let cgImage = image.cgImage else {
            return 200
        }
        
        let imageWidth = CGFloat(cgImage.width)
        let imageHeight = CGFloat(cgImage.height)
        let tableViewWidth = tableView.bounds.width
        let cellWidth = tableViewWidth - 16 * 2
        
        let result = cellWidth * imageHeight / imageWidth + 8
        
        return result
    }
}
