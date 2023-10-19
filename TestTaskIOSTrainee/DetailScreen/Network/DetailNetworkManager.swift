//
//  DetailNetwork.swift
//  TestTaskIOSTrainee
//
//  Created by Dima on 19.10.2023.
//

import Foundation

final class DetailNetworkManager {
    
    func fetchData(completion: @escaping (DetailModel?) -> Void) {
        
        let urlString = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/posts/111.json"
        guard let url = URL(string: urlString) else { return }
        
        let data = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Erorr fetching data: \(error.localizedDescription)")
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
                let decodedData = try decoder.decode(DetailPostModel.self, from: jsonData)
                DispatchQueue.main.async {
                    completion(decodedData.post)
                }
            } catch {
                print("Erorr decoding data: \(error.localizedDescription)")
                completion(nil)
            }
        }
        data.resume()
    }
}
