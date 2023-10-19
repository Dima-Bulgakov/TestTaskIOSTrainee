//
//  DetailModel.swift
//  TestTaskIOSTrainee
//
//  Created by Dima on 19.10.2023.
//

import Foundation

struct DetailPostModel: Decodable {
    let post: DetailModel
}

struct DetailModel: Decodable {
    let postId: Int
    let timeshamp: Int
    let title: String
    let text: String
    let postImage: URL?
    let likesCount: Int
}
