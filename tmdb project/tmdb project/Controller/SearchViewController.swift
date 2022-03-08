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
    private(set) var data: [Movie] = []
    private var page: Int = 1
    
    private var timer: Timer?
    private var autoSearchWorkItem: DispatchWorkItem?
    private var enterSearchWorkItem: DispatchWorkItem?
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.cellID)
        return collectionView
    }()
    
    private lazy var searchHeaderView: SearchHeaderView = {
        let view = SearchHeaderView()
        return view
    }()
    
    private(set) lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.searchTextField.placeholder = "Search"
        searchController.searchBar.barStyle = .black
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.automaticallyShowsCancelButton = false
        return searchController
    }()
    
    private lazy var searchNoResultView: UILabel = {
        let label = UILabel()
        label.text = "검색결과 없음"
        label.textColor = .white
        return label
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        layout.itemSize = CGSize(width: view.frame.width * 0.9, height: view.frame.height * 0.2)
        layout.scrollDirection = .vertical
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        setLayout()
        setNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchController.searchBar.searchTextField.rightView = UIImageView(image: UIImage(systemName: "mic"))
        searchController.searchBar.searchTextField.rightViewMode = .always
    }
    
    private func setLayout() {
        view.addSubview(collectionView)
        view.addSubview(searchNoResultView)
        searchNoResultView.translatesAutoresizingMaskIntoConstraints = false
        searchNoResultView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchNoResultView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }
    
    private func setNavigationBar() {
        navigationItem.titleView = searchHeaderView
        navigationItem.searchController = searchController
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func updateURL(with queryItems: [URLQueryItem]) {
        targetAPI.settingQueryItems(queryItems: queryItems)
    }
    
    func fetchData(with searchQuery: String) {
        updateURL(with: [targetAPI.generateQueryItem(item: TMDBAPI.SearchQuery.apiKey, value: targetAPI.apiKey),
                         targetAPI.generateQueryItem(item: TMDBAPI.SearchQuery.query, value: searchQuery),
                         targetAPI.generateQueryItem(item: TMDBAPI.SearchQuery.language, value: "ko-KR"),
                         targetAPI.generateQueryItem(item: TMDBAPI.SearchQuery.page, value: "\(page)"),
                         targetAPI.generateQueryItem(item: TMDBAPI.SearchQuery.includeAdult, value: "false")])
        networkManager.fetchData(url: targetAPI.targetURL()) { result in
            if case .success(let data) = result {
                guard let searchMovieList = try? JSONDecoder().decode(SearchMovieList.self, from: data) else {
                    return
                }
                self.data.append(contentsOf: searchMovieList.results)
                self.page += 1
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    if self.data.isEmpty {
                        self.searchNoResultView.text = "검색결과 없음"
                    } else {
                        self.searchNoResultView.text = ""
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.searchNoResultView.text = "검색결과 없음"
                }
            }
        }
    }
    
    private func resetData() {
        self.page = 1
        self.data = []
    }
}

// MARK: Search 관련 Delegate 구현부
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchController.searchBar.searchTextField.text else {
            return
        }
        autoSearchWorkItem?.cancel()
        resetData()
        let searchWorkItem = DispatchWorkItem {
            self.fetchData(with: query)
        }
        enterSearchWorkItem = searchWorkItem
        DispatchQueue(label: "serial").sync(execute: searchWorkItem)
        debugPrint(#function)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.searchTextField.text else { return }
        resetData()
        timer?.invalidate()
        let searchWorkItem = DispatchWorkItem {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in
                if self.autoSearchWorkItem?.isCancelled == true {
                    return
                }
                self.fetchData(with: query)
            })
        }
        autoSearchWorkItem = searchWorkItem
        DispatchQueue(label: "serial").sync(execute: searchWorkItem)
    }
}
