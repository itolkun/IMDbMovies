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
    
    private var movies: [Movie] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        fetchMovies()
        
    }
}



extension MovieInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellTwo", for: indexPath) as! UserAddedMovie
        let movie = movies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
    func fetchMovies() {
        NetworkManager.shared.fetchMovies(by: "santa") {
            [] result in
            switch result {
            case .success(let searchResult):
                self.movies = searchResult.movies
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
        
    }
}

