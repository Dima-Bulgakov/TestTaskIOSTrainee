//
//  DetailViewModel.swift
//  TestTaskIOSTrainee
//
//  Created by Dima on 19.10.2023.
//

import Foundation

class DetailViewModel {
    
    let detailNetworkManager = DetailNetworkManager()
    var post: DetailModel?
    
    func getPost(completion: @escaping (DetailModel?) -> Void) {
        detailNetworkManager.fetchData { result in
            self.post = result
            completion(result)
        }
    }
}
