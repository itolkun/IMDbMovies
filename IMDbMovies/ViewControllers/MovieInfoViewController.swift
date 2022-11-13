//
//  ViewController.swift
//  IMDbMovies
//
//  Created by Айтолкун Анарбекова on 8/11/22.
//

import UIKit

class MovieInfoViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var choosenMovieImage: UIImageView!
    
    var selectedMovie: Movie!
    
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        fetchMovies()
        fetchMovieInfo()
        
    }
}

extension MovieInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellTwo", for: indexPath) as! MovieInfo
        let movie = movies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
    
    func fetchMovies() {
        NetworkManager.shared.fetchMovies(
            by: selectedMovie.title.split(
                separator: " ").prefix(2).joined(separator: "+")
        ) {
            result in
            switch result {
            case .success(let searchResult):
                self.movies = searchResult.movies
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
                
            }
        }
        
    }
    
    func fetchMovieInfo() {
        NetworkManager.shared.fetchMovieInfo(by: selectedMovie.imdbID) {
            result in
            switch result {
            case .success(let movieInfo):
                NetworkManager.shared.fetchMovieImage(from: movieInfo.poster){ [weak self] result in
                    switch result {
                    case .success(let imageData):
                        self?.choosenMovieImage.image = UIImage(data: imageData)
                    case .failure(_):
                        self?.choosenMovieImage.image = UIImage(named: "moviePoster")
                    }
                }
            case .failure(let error):
                print(error)
                
            }
        }
        
    }
}
