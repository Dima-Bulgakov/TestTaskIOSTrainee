//
//  MainViewModel.swift
//  TestTaskIOSTrainee
//
//  Created by Dima on 19.10.2023.
//

import UIKit

final class MainViewModel {
    
    // MARK: - Properties
    private let mainNetworkManager = MainNetworkManager()
    private var posts: [PostModel] = []
    private var topMenu = UIMenu()
    
    // MARK: - Methods
    func getPosts(completion: @escaping () -> Void) {
        mainNetworkManager.fetchData { [weak self] posts in
            if let posts = posts {
                self?.posts = posts
            }
            completion()
        }
    }
    
    /// Number of posts
    func postsCount() -> Int {
        return posts.count
    }
    
    /// Post with index
    func indexPost(at index: Int) -> PostModel {
        return posts[index]
    }
    
    /// Sorting methods for SorButton
    func sortPostsByDate() {
        posts.sort { $0.timeshamp > $1.timeshamp }
    }

    func sortPostsByRate() {
        posts.sort { $0.likesCount > $1.likesCount }
    }
    
    /// Convert data date
    func formattedDateForPost(at index: Int) -> String {
        let post = posts[index]
        let date = Date(timeIntervalSince1970: TimeInterval(post.timeshamp))
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.day], from: date, to: now)
        
        let oneDayAgo = "1 day ago"
        let endFirst = "day ago"
        let manyDays = "days ago"
        
        if let daysAgo = components.day {
            if daysAgo == 1 {
                return oneDayAgo
            } else if daysAgo > 1 {
                if daysAgo % 10 == 1 && daysAgo % 100 != 11 {
                    return "\(daysAgo) \(endFirst)"
                } else {
                    return "\(daysAgo) \(manyDays)"
                }
            } else if daysAgo < 1 {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                let timeString = dateFormatter.string(from: date)
                return "Today at \(timeString)"
            }
        }
        return ""
    }
}
