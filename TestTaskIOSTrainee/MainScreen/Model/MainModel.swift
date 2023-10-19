//
//  MainModel.swift
//  TestTaskIOSTrainee
//
//  Created by Dima on 19.10.2023.
//

import Foundation

struct PostModel: Decodable {
    let postId: Int
    let timeshamp: Int
    let title: String
    let previewText: String
    let likesCount: Int
}

struct PostsResponse: Decodable {
    let posts: [PostModel]
}
