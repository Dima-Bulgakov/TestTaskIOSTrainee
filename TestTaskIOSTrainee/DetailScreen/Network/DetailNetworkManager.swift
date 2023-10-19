//
//  DetailNetwork.swift
//  TestTaskIOSTrainee
//
//  Created by Dima on 19.10.2023.
//

import UIKit

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
    
    func loadImage(from imageURL: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            if let error = error {
                print("Error fetching image data: \(error.localizedDescription)")
                completion(nil)
            } else if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}
