//
//  MainController.swift
//  MovieApp
//
//  Created by Sailau Almaz Maratuly on 08.02.2023.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    private var apiCaller = APICaller()
    private var allMoviesList: [[MovieModel]] = []
    private var genreList: [Int:String] = [:]
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let categoryList = Category.allCases
    
    private lazy var movieSearchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search movies, series, tv shows"
        return searchBar
    }()
    
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.typeName)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var trendingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TrendingCollectionViewCell.self, forCellWithReuseIdentifier: TrendingCollectionViewCell.typeName)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieTableCollectionViewCell.self, forCellReuseIdentifier: MovieTableCollectionViewCell.typeName)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiCaller.delegate = self
        apiCaller.fetchRequest(.movie)
        
        setupViews()
        setupConstraints()
    }
}

//MARK: - API Caller delegate methods

extension MainViewController: APICallerDelegate {
    
    func didUpdateAllMovieList(with movieList: [MovieModel]) {
        self.allMoviesList.append(movieList)
        DispatchQueue.main.async {
            self.trendingCollectionView.reloadData()
            self.movieTableView.reloadData()
        }
    }
    
    func didUpdateGenreList(with genreList: [Int : String]) {
        self.genreList = genreList
        DispatchQueue.main.async {
            self.trendingCollectionView.reloadData()
            self.movieTableView.reloadData()
        }
    }
}

//MARK: - Collection view data source methods

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return categoryList.count
        }
        if allMoviesList.isEmpty {
            return 0
        }
        return allMoviesList[0].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.typeName, for: indexPath) as! CategoryCollectionViewCell
            cell.configure(with: categoryList[indexPath.row].rawValue)
            cell.backgroundColor = .systemGray6
            cell.layer.cornerRadius = 5
            cell.clipsToBounds = true
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionViewCell.typeName, for: indexPath) as! TrendingCollectionViewCell
        cell.configure(with: allMoviesList[0][indexPath.item].backdropPath)
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        return cell
    }
}

//MARK: - Collection view delegate flow methods

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView {
            let label = UILabel()
            label.text = categoryList[indexPath.row].rawValue
            label.sizeToFit()
            return CGSize(width: label.frame.size.width + 30, height: collectionView.frame.size.height - 10)
        }
        let height = collectionView.frame.size.height
        return CGSize(width: view.frame.size.width * 0.75, height: height)
    }
}

//MARK: - Collection view delegate methods

extension MainViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == trendingCollectionView {
            let vc = DetailsViewController()
            vc.apiCaller = self.apiCaller
            vc.configure(with: allMoviesList[0][indexPath.item].id)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - Table view data source methods

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionHeaderView()
        let title = String(categoryList[section].rawValue.dropFirst())
        view.configure(with: title, number: 6)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if allMoviesList.count == Constants.Values.urlList.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableCollectionViewCell.typeName, for: indexPath) as! MovieTableCollectionViewCell
            cell.apiCaller = apiCaller
            cell.navigationController = navigationController
            cell.configure(with: allMoviesList[indexPath.section + 1], and: genreList)
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: - Table view delegate methods

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height * 0.3
    }
}

//MARK: - Setup views and constraints

private extension MainViewController {
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(movieSearchBar)
        contentView.addSubview(categoryCollectionView)
        contentView.addSubview(trendingCollectionView)
        contentView.addSubview(movieTableView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalTo(view).inset(15)
        }
        movieSearchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(view).multipliedBy(0.06)
        }
        movieSearchBar.searchTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(movieSearchBar.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view).multipliedBy(0.06)
        }
        trendingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view).multipliedBy(0.2)
        }
        movieTableView.snp.makeConstraints { make in
            make.top.equalTo(trendingCollectionView.snp.bottom).offset(10)
            make.height.equalTo(view).multipliedBy(1.6)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
