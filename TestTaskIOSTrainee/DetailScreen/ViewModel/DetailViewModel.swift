//
//  DetailViewModel.swift
//  TestTaskIOSTrainee
//
//  Created by Dima on 19.10.2023.
//

import UIKit

class DetailViewModel {
    
    // MARK: - Properties
    let detailNetworkManager = DetailNetworkManager()
    var post: DetailModel?
    
    // MARK: - Methods
    func getPost(completion: @escaping (DetailModel?) -> Void) {
        detailNetworkManager.fetchData { result in
            self.post = result
            completion(result)
        }
    }
    
    func loadImage(from imageURL: URL, completion: @escaping (UIImage?) -> Void) {
            detailNetworkManager.loadImage(from: imageURL, completion: completion)
        }
}
