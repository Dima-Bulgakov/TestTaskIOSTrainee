//
//  DetailViewModel.swift
//  TestTaskIOSTrainee
//
//  Created by Dima on 19.10.2023.
//

import UIKit

final class DetailViewModel {
    
    // MARK: - Properties
    let detailNetworkManager = DetailNetworkManager()
    var post: DetailModel?
    var selectedID: String?
    
    // MARK: - Methods
    /// Load data and update the post property
    func loadData(completion: @escaping () -> Void) {
        detailNetworkManager.selectedId = selectedID
        detailNetworkManager.fetchData { [weak self] result in
            self?.post = result
            completion()
        }
    }
    
    /// Load image method
    func loadImage(from imageURL: URL, completion: @escaping (UIImage?) -> Void) {
        detailNetworkManager.fetchImage(from: imageURL, completion: completion)
    }
    
    /// Convert data date
    func convertIntToDate(_ timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: date)
    }
}
