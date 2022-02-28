//
//  SearchViewController+DataSource.swift
//  tmdb project
//
//  Created by 박태현 on 2022/02/28.
//

import UIKit

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.cellID, for: indexPath) as? SearchCollectionViewCell else {
            let cell = SearchCollectionViewCell()
            cell.setUpCell(movie: data[indexPath.row])
            return cell
        }
        cell.setUpCell(movie: data[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
}


extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.last?.row == data.count - 1 {
            guard let query = searchController.searchBar.searchTextField.text else { return }
            fetchData(with: query)
        }
    }
}
