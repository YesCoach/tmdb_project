//
//  SearchViewController.swift
//  tmdb project
//
//  Created by 박태현 on 2022/02/23.
//

import UIKit

class SearchViewController: UIViewController {
    private let networkManager = NetworkManager()
    private var targetAPI = TMDBAPI(of: TMDBAPI.SearchAPI.movie)
    private var data: [Movie] = []
    private var page: Int = 1

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.cellID)
        return collectionView
    }()

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        layout.itemSize = CGSize(width: view.frame.width * 0.9, height: view.frame.height * 0.3)
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var searchHeaderView: SearchHeaderView = {
        let view = SearchHeaderView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        setLayout()
        fetchData()
        // Do any additional setup after loading the view.
    }

    private func setLayout() {
        view.addSubview(collectionView)
        view.addSubview(searchHeaderView)
        searchHeaderView.translatesAutoresizingMaskIntoConstraints = false
        searchHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        searchHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: searchHeaderView.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }

    private func updateURL(with queryItems: [URLQueryItem]) {
        targetAPI.settingQueryItems(queryItems: queryItems)
    }

    private func fetchData() {
        updateURL(with: [targetAPI.generateQueryItem(item: TMDBAPI.SearchQuery.apiKey, value: targetAPI.apiKey),
                         targetAPI.generateQueryItem(item: TMDBAPI.SearchQuery.query, value: "ko_KR"),
                         targetAPI.generateQueryItem(item: TMDBAPI.SearchQuery.language, value: "ko_KR"),
                         targetAPI.generateQueryItem(item: TMDBAPI.SearchQuery.page, value: "\(page)"),
                         targetAPI.generateQueryItem(item: TMDBAPI.SearchQuery.includeAdult, value: "false")])
        print(targetAPI.targetURL())
        networkManager.fetchData(url: targetAPI.targetURL()) { result in
            if case .success(let data) = result {
                guard let searchMovieList = try? JSONDecoder().decode(SearchMovieList.self, from: data) else {
                    return
                }
                self.data.append(contentsOf: searchMovieList.results)
                self.page += 1
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

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
            fetchData()
        }
    }
}
