//
//  NetworkManager.swift
//  tmdb project
//
//  Created by 박태현 on 2022/02/21.
//

import UIKit

struct NetworkManager {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchData(url: URL, completion: @escaping(Result<Data, Error>) -> Void) {
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(error))
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                return completion(.failure(NetworkError.invalidResponse))
            }
            guard let data = data else {
                return completion(.failure(NetworkError.invalidData))
            }
            completion(.success(data))
        }.resume()
    }

    func dataTask(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.invalidRequest))
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }

            if let data = data {
                completion(.success(data))
            }
        }.resume()
    }
}
extension NetworkManager {
    func downloadImage(from link: String, success block: @escaping (UIImage) -> Void) {
        guard let url = URL(string: link) else { return }
        print(url)
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            block(image)
        }.resume()
    }
}
