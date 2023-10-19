//
//  MainNetworkManager.swift
//  TestTaskIOSTrainee
//
//  Created by Dima on 19.10.2023.
//

import Foundation

final class MainNetworkManager {
    
    func fetchData(completion: @escaping ([PostModel]?) -> Void) {
        let urlString = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json"
        guard let url = URL(string: urlString) else { return }
        
        let data = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching post: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let jsonData = data else {
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let decodedData = try decoder.decode(PostsResponse.self, from: jsonData)
                DispatchQueue.main.async {
                    completion(decodedData.posts)
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(nil)
            }
        }
        data.resume()
    }
}
