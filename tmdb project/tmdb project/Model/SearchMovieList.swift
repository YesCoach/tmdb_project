//
//  SearchMovieList.swift
//  tmdb project
//
//  Created by 박태현 on 2022/02/24.
//

import Foundation

struct SearchMovieList: Decodable {
    let page: Int
    let results: [Movie]
}
