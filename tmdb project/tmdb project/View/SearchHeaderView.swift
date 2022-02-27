//
//  SearchHeaderView.swift
//  tmdb project
//
//  Created by 박태현 on 2022/02/24.
//

import UIKit

class SearchHeaderView: UICollectionReusableView {
    static let viewID = "searchHeaderViewID"

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "검색"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setLayout() {
        self.backgroundColor = .black
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
    }
}
