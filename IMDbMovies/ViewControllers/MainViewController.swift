//
//  MainViewController.swift
//  IMDbMovies
//
//  Created by Айтолкун Анарбекова on 8/11/22.
//

import UIKit

class MainViewController: UICollectionViewController {
    
    private var movies: [Movie] = []
    
    private var selectedMovie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedMovie = movies[indexPath.item]
        performSegue(withIdentifier: "movieInfo", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movieInfoVC = segue.destination as? MovieInfoViewController
        movieInfoVC?.selectedMovie = self.selectedMovie
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 24, height: 220)
    }
}

extension MainViewController {
    func fetchMovies() {
        NetworkManager.shared.fetchMovies(by: "christmas") {
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
    
}
