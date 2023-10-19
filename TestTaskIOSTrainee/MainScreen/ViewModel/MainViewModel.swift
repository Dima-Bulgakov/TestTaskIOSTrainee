//
//  MainViewModel.swift
//  TestTaskIOSTrainee
//
//  Created by Dima on 19.10.2023.
//

import Foundation

final class MainViewModel {
    
    // MARK: - Properties
    private let mainNetworkManager = MainNetworkManager()
    private var posts: [PostModel] = []
    
    // MARK: - Methods
    func getPosts(completion: @escaping () -> Void) {
        mainNetworkManager.fetchData { [weak self] posts in
            if let posts = posts {
                self?.posts = posts
            }
            completion()
        }
    }
    
    func postsCount() -> Int {
        return posts.count
    }
    
    func indexPost(at index: Int) -> PostModel {
        return posts[index]
    }
}
