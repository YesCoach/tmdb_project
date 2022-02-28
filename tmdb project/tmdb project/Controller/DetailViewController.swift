//
//  DetailViewController.swift
//  tmdb project
//
//  Created by 박태현 on 2022/02/23.
//

import UIKit

class DetailViewController: UIViewController {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private lazy var detailInfoView: DetailInfoView = {
        let detailInfoview = DetailInfoView()
        return detailInfoview
    }()

    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        configure()
    }
    
    func setUpLayout() {
        view.addSubview(stackView)
        stackView.addSubview(detailInfoView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    func configure() {
        guard let movie = movie else {
            return
        }
        detailInfoView.configure(with: movie)
    }
}
