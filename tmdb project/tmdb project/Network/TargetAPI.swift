//
//  TargetURL.swift
//  tmdb project
//
//  Created by 박태현 on 2022/02/21.
//

import Foundation

enum TMDBAPI {
    case now_playing

    static let baseURL = "https://api.themoviedb.org/3/movie/"
    var url: String {
        switch self {
        case.now_playing:
            return Self.baseURL + "now_playing"
        }
    }
}

enum MovieQuery {
    case apiKey
    case language
    case page
}

class TargetAPI {
    private var components = URLComponents(string: "\(TMDBAPI.now_playing.url)")
    let apiKey = URLQueryItem(name: "api_key", value: "b8f03fc5e25bdeaaa478064e15410d68")
    let language = URLQueryItem(name: "language", value: "ko_KR")
    let page = URLQueryItem(name: "page", value: "1")

    func targetURL() -> URL? {
        components?.queryItems = [apiKey,language,page]
        return components?.url
    }
}
