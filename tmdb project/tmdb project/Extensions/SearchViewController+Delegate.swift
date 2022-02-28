//
//  SearchViewController+Delegate.swift
//  tmdb project
//
//  Created by 박태현 on 2022/02/28.
//

import UIKit

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.movieID = data[indexPath.row].id
        navigationController?.pushViewController(detailViewController, animated: false)
    }
}
