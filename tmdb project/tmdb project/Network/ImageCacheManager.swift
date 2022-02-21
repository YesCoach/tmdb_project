//
//  ImageCacheManager.swift
//  tmdb project
//
//  Created by 박태현 on 2022/02/21.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
