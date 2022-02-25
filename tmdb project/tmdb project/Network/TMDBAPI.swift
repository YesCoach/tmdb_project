//
//  TargetURL.swift
//  tmdb project
//
//  Created by 박태현 on 2022/02/21.
//

import Foundation

class TMDBAPI {
    let apiKey = "b8f03fc5e25bdeaaa478064e15410d68"
    private var components = URLComponents(string: "\(MovieAPI.now_playing.url)")
    private var urlQueryItems: [URLQueryItem]?

    init(of api: API, with queryItems: [URLQueryItem] = []) {
        components = URLComponents(string: "\(api.url)")
        urlQueryItems = queryItems
    }

    func targetURL() -> URL? {
        components?.queryItems = urlQueryItems
        return components?.url
    }

    func generateQueryItem(item: Query, value: String) -> URLQueryItem {
        return URLQueryItem(name: "\(item.name)", value: value)
    }

    func settingQueryItems(queryItems: [URLQueryItem]) {
        self.urlQueryItems = queryItems
    }
}

extension TMDBAPI {
    enum MovieAPI: API {
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
    
    enum SearchAPI: API {
        case movie
        case tv

        static let baseURL = "https://api.themoviedb.org/3/search/"

        var url: String {
            switch self {
            case .movie:
                return Self.baseURL + "movie"
            case .tv:
                return Self.baseURL + "tv"
            }
        }
    }

    enum MovieQuery: Query {
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

    enum SearchQuery: Query {
        case apiKey
        case query
        case language
        case page
        case includeAdult

        var name: String {
            switch self {
            case .apiKey:
                return "api_key"
            case .query:
                return "query"
            case .language:
                return "language"
            case .page:
                return "page"
            case .includeAdult:
                return "include_adult"
            }
        }
    }
}

protocol API {
    static var baseURL: String { get }
    var url: String { get }
}

protocol Query {
    var name: String { get }
}
