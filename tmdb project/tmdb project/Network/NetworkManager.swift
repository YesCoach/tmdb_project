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

    func fetchData(url: URL?, completion: @escaping(Result<Data, Error>) -> Void) {
        guard let url = url else { return }
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
}

//MARK: Image Fetching
extension NetworkManager {
    func downloadImage(from url: String, completion: @escaping (UIImage) -> Void) {
        let cacheKey = NSString(string: url)
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            completion(cachedImage)
        }

        guard let url = URL(string: url) else { return }
        session.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            ImageCacheManager.shared.setObject(image, forKey: cacheKey)
            completion(image)
        }.resume()
    }
}
