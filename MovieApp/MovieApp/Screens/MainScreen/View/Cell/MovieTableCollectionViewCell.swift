//
//  MovieTableCollectionViewCell.swift
//  MovieApp
//
//  Created by Sailau Almaz Maratuly on 09.02.2023.
//

import UIKit

final class MovieTableCollectionViewCell: UITableViewCell {
    
    private var movieList: [MovieModel] = []
    
    private lazy var movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Identifiers.movieCollectionViewCell)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movieList: [MovieModel]) {
        self.movieList = movieList
        DispatchQueue.main.async {
            self.movieCollectionView.reloadData()
        }
    }
}

//MARK: - Collection view data source and delegate methods

extension MovieTableCollectionViewCell: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return movieList.count
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.movieCollectionViewCell, for: indexPath) as! MovieCollectionViewCell
        cell.clipsToBounds = true
//        cell.configure(with: movieList[indexPath.row])
        return cell
    }
}

extension MovieTableCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height
        return CGSize(width: height/2, height: height)
    }
}

//MARK: - Setup views and constraints

extension MovieTableCollectionViewCell {
    func setupViews() {
        contentView.addSubview(movieCollectionView)
    }
    
    func setupConstraints() {
        movieCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
