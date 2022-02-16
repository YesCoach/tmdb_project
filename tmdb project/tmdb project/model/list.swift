//
//  List.swift
//  tmdb project
//
//  Created by 박태현 on 2022/02/14.
//

import Foundation

struct MovieList: Decodable {
    let page: Int
    let results: [Movie]
}
