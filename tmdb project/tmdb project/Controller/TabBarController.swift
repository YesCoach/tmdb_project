//
//  TabBarController.swift
//  tmdb project
//
//  Created by 박태현 on 2022/02/23.
//

import UIKit

class TabBarController: UITabBarController {
    private lazy var mainViewController: MainViewController = {
        let viewController = MainViewController()
        return viewController
    }()
    private lazy var searchViewController: SearchViewController = {
        let viewController = SearchViewController()
        return viewController
    }()
    private lazy var genreViewController: GenreViewController = {
        let viewController = GenreViewController()
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewController.tabBarItem.title = "홈"
        searchViewController.tabBarItem.title = "검색"
        genreViewController.tabBarItem.title = "장르"
        self.viewControllers = [mainViewController,searchViewController,genreViewController]
    }
}
