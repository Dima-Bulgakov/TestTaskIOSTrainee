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
    
    // MARK: - Methods
    func convertIntToDate(_ timestamp: Int) -> String {
        /// Convert data date from API to "dd MMMM yyyy"
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: date)
    }
}
