//
//  DetailViewController.swift
//  tmdb project
//
//  Created by 박태현 on 2022/02/23.
//

import UIKit

class DetailViewController: UIViewController {
    private let networkManager = NetworkManager()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private lazy var detailInfoView: DetailInfoView = {
        let detailInfoview = DetailInfoView()
        return detailInfoview
    }()
    
    var movieID: Int?
    private var data: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        fetchData()
    }
    
    private func setUpLayout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(detailInfoView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    private func fetchData() {
        guard let movieID = movieID else {
            return
        }
        let targetAPI = TMDBAPI(of: TMDBAPI.MovieAPI.detail(movieID))
        targetAPI.settingQueryItems(queryItems:
                                        [targetAPI.generateQueryItem(item: TMDBAPI.MovieQuery.apiKey, value: "b8f03fc5e25bdeaaa478064e15410d68"),
                                         targetAPI.generateQueryItem(item: TMDBAPI.MovieQuery.language, value: "ko_KR")])
        
        networkManager.fetchData(url: targetAPI.targetURL()) { result in
            if case .success(let data) = result {
                guard let movie = try? JSONDecoder().decode(Movie.self, from: data) else {
                    return
                }
                self.data = movie
                self.configure()
            }
        }
    }
    
    private func configure() {
        guard let movie = data else {
            return
        }
        DispatchQueue.main.async {
            self.detailInfoView.configure(with: movie)
        }
        movie.image { image in
            DispatchQueue.main.async {
                self.stackView.backgroundColor = UIColor(patternImage: image)
            }
        }
    }
}
