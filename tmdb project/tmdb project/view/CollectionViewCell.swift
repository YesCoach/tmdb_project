//
//  CollectionViewCell.swift
//  tmdb project
//
//  Created by 박태현 on 2022/02/20.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let cellID = "CustomCollectionViewCellID"

    private lazy var thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private lazy var popularityIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        return imageView
    }()

    private lazy var popularityLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpLayout() {
        contentView.addSubview(thumbnailView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(popularityIcon)
        contentView.addSubview(popularityLabel)

        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        thumbnailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        thumbnailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        thumbnailView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: 0.8).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true

        popularityIcon.translatesAutoresizingMaskIntoConstraints = false
        popularityIcon.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        popularityIcon.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true

        popularityLabel.translatesAutoresizingMaskIntoConstraints = false
        popularityLabel.topAnchor.constraint(equalTo: popularityIcon.topAnchor).isActive = true
        popularityLabel.leadingAnchor.constraint(equalTo: popularityIcon.trailingAnchor).isActive = true
        popularityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        popularityLabel.bottomAnchor.constraint(equalTo: popularityIcon.bottomAnchor).isActive = true
    }
    func setUpCell(thumbnail: UIImage?, title: String, popularity: Double) {
        thumbnailView.image = thumbnail ?? nil
        titleLabel.text = title
        popularityLabel.text = String(popularity)
    }
    override func prepareForReuse() {
        thumbnailView.image = nil
        titleLabel.text = nil
        popularityLabel.text = nil
    }
}
