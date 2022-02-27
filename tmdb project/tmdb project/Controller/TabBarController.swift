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
        viewController.tabBarItem.title = "홈"
        viewController.changeTabBarItemFontColorWhite()
        return viewController
    }()
    private lazy var searchViewController: SearchViewController = {
        let viewController = SearchViewController()
        viewController.tabBarItem.title = "검색"
        viewController.changeTabBarItemFontColorWhite()
        return viewController
    }()
    private lazy var genreViewController: GenreViewController = {
        let viewController = GenreViewController()
        viewController.tabBarItem.title = "장르"
        viewController.changeTabBarItemFontColorWhite()
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [mainViewController,
                                UINavigationController(rootViewController: searchViewController),
                                genreViewController]
        setUpTabBar()
    }

    private func setUpTabBar() {
        tabBar.barTintColor = .black
        tabBar.isTranslucent = false
    }
}

extension UIViewController {
    func changeTabBarItemFontColorWhite(){
        self.tabBarItem.setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white], for: .normal)
    }
}
