//
//  MainViewController.swift
//  tmdb project
//
//  Created by 박태현 on 2022/02/14.
//

import UIKit

class MainViewController: UIViewController {
    private let networkManager = NetworkManager()
    private var targetAPI = TMDBAPI(of: TMDBAPI.MovieAPI.now_playing)
    private var data: [Movie] = []
    private var page: Int = 1

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.cellID)
        return collectionView
    }()

    private lazy var headerView: UIView = {
        let view = MainHeaderView()
        return view
    }()

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        layout.itemSize = CGSize(width: view.frame.width * 0.44, height: view.frame.height * 0.35)
        layout.scrollDirection = .vertical
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.delegate = self
        setLayout()
        fetchData()
        navigationItem.titleView = headerView
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        // Do any additional setup after loading the view.
    }

    private func setLayout() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }
    private func updateURL(with queryItems: [URLQueryItem]) {
        targetAPI.settingQueryItems(queryItems: queryItems)
    }

    private func fetchData() {
        updateURL(with: [targetAPI.generateQueryItem(item: TMDBAPI.MovieQuery.apiKey, value: "b8f03fc5e25bdeaaa478064e15410d68"),
                         targetAPI.generateQueryItem(item: TMDBAPI.MovieQuery.language, value: "ko_KR"),
                         targetAPI.generateQueryItem(item: TMDBAPI.MovieQuery.page, value: "\(page)")])
        networkManager.fetchData(url: targetAPI.targetURL()) { result in
            if case .success(let data) = result {
                guard let movieList = try? JSONDecoder().decode(MovieList.self, from: data) else {
                    return
                }
                self.data.append(contentsOf: movieList.results)
                self.page += 1
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.cellID, for: indexPath) as? MainCollectionViewCell else {
            let cell = MainCollectionViewCell()
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

extension MainViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.last?.row == data.count - 1 {
            fetchData()
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.movieID = data[indexPath.row].id
        navigationController?.pushViewController(detailViewController, animated: false)
    }
}
