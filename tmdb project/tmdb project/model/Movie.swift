//
//  Movie.swift
//  tmdb project
//
//  Created by 박태현 on 2022/02/14.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}
