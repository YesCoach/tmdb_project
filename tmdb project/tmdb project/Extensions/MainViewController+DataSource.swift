//
//  MainViewController+Datasource.swift
//  tmdb project
//
//  Created by 박태현 on 2022/02/28.
//

import UIKit

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.cellID, for: indexPath) as? MainCollectionViewCell else {
            let cell = MainCollectionViewCell()
            return cell
        }
        cell.setUpCell(movie: data[indexPath.row]) { image in
            DispatchQueue.main.async {
                if indexPath == collectionView.indexPath(for: cell) {
                    cell.thumbnailView.image = image
                }
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
}

extension MainViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.last?.row == data.count - 1 {
            fetchData()
        }
    }
}
