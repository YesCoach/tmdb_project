//
//  Movie.swift
//  tmdb project
//
//  Created by 박태현 on 2022/02/14.
//

import UIKit

struct Movie: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    let voteAverage: Double
    let releaseDate: String
    let genres: [Genre]?
    let runtime: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, genres, runtime
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }

    func image(completion: @escaping (UIImage) -> Void) {
        if let posterPath = posterPath {
            let url = "https://image.tmdb.org/t/p/original" + posterPath
            NetworkManager().downloadImage(from: url) { image in
                completion(image)
            }
        }
    }
}
