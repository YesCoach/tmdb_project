//
//  TargetURL.swift
//  tmdb project
//
//  Created by 박태현 on 2022/02/21.
//

import Foundation

enum TMDBAPI {
    case now_playing
    case popular
    
    static let baseURL = "https://api.themoviedb.org/3/movie/"

    var url: String {
        switch self {
        case.now_playing:
            return Self.baseURL + "now_playing"
        case.popular:
            return Self.baseURL + "popular"
        }
    }
}

enum MovieQuery {
    case apiKey
    case language
    case page

    var name: String {
        switch self {
        case .apiKey:
            return "api_key"
        case .language:
            return "language"
        case .page:
            return "page"
        }
    }
}

class TargetAPI {
    private var components = URLComponents(string: "\(TMDBAPI.now_playing.url)")
    private var urlQueryItems: [URLQueryItem]?

    init(of api: TMDBAPI, with queryItems: [URLQueryItem] = []) {
        components = URLComponents(string: "\(api.url)")
        urlQueryItems = queryItems
    }

    func targetURL() -> URL? {
        components?.queryItems = urlQueryItems
        return components?.url
    }

    func generateQueryItem(item: MovieQuery, value: String) -> URLQueryItem {
        return URLQueryItem(name: "\(item.name)", value: value)
    }

    func settingQueryItems(queryItems: [URLQueryItem]) {
        self.urlQueryItems = queryItems
    }
}
