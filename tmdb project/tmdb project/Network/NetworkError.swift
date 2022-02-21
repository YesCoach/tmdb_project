//
//  NetworkError.swift
//  tmdb project
//
//  Created by 박태현 on 2022/02/21.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case invalidData
}
