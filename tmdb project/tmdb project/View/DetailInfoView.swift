//
//  DetailInfoView.swift
//  tmdb project
//
//  Created by 박태현 on 2022/02/28.
//

import UIKit

class DetailInfoView: UIView {
    private lazy var thumbnailView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.settingCommonForm()
        return label
    }()
    
    private lazy var releaseLabel: UILabel = {
        let label = UILabel()
        label.settingCommonForm()
        return label
    }()
    
    private lazy var runtimeLabel: UILabel = {
        let label = UILabel()
        label.settingCommonForm()
        return label
    }()
    
    private lazy var popularityLabel: UILabel = {
        let label = UILabel()
        label.settingCommonForm()
        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.settingCommonForm()
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayout() {
        self.addSubview(thumbnailView)
        self.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(releaseLabel)
        stackView.addArrangedSubview(runtimeLabel)
        stackView.addArrangedSubview(popularityLabel)
        stackView.addArrangedSubview(genreLabel)
        
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        thumbnailView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        thumbnailView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        thumbnailView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
        stackView.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: thumbnailView.bottomAnchor).isActive = true
    }
    
    func configure(with movie: Movie) {
        movie.image { image in
            DispatchQueue.main.async {
                self.thumbnailView.image = image
            }
        }
        titleLabel.text = movie.title
        releaseLabel.text = "개봉일: " + movie.releaseDate
        if let runtime = movie.runtime {
            runtimeLabel.text = "런타임: " + String(runtime) + "분"
        }
        popularityLabel.text = "평점: " + String(movie.voteAverage)
        
        var genreText = "장르: "
        if let genres = movie.genres {
            for genre in genres {
                genreText += "\(genre.name), "
            }
            genreText.removeLast(2)
        }
        genreLabel.text = genreText
    }
}
