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
        viewController.tabBarItem.image = UIImage(systemName: "1.circle.fill")
        viewController.changeTabBarItemFontColorWhite()
        return viewController
    }()
    private lazy var searchViewController: UINavigationController = {
        let viewController = UINavigationController(rootViewController: SearchViewController())
        viewController.tabBarItem.title = "검색"
        viewController.tabBarItem.image = UIImage(systemName: "2.circle.fill")
        viewController.changeTabBarItemFontColorWhite()
        return viewController
    }()
    private lazy var genreViewController: GenreViewController = {
        let viewController = GenreViewController()
        viewController.tabBarItem.title = "장르"
        viewController.tabBarItem.image = UIImage(systemName: "3.circle.fill")
        viewController.changeTabBarItemFontColorWhite()
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [mainViewController,
                                searchViewController,
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
