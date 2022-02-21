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
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
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
