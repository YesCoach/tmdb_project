//
//  MainViewController.swift
//  tmdb project
//
//  Created by 박태현 on 2022/02/14.
//

import UIKit

struct Data {
    let image: UIImage?
    let title: String
    let popularity: Double
}

class MainViewController: UIViewController {
    let data: [Data] = [Data(image: UIImage(named: "ph1.jpg"), title: "the island kid", popularity: 9.91)]

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.cellID)
        return collectionView
    }()

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: view.frame.width * 0.35, height: view.frame.height * 0.3)
        layout.scrollDirection = .vertical
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view.
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = data[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.cellID, for: indexPath) as? CollectionViewCell else {
            let cell = CollectionViewCell()
            cell.setUpCell(thumbnail: data.image, title: data.title, popularity: data.popularity)
            return cell
        }
        cell.setUpCell(thumbnail: data.image, title: data.title, popularity: data.popularity)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 200)
    }
}
