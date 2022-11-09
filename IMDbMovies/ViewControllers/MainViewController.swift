//
//  MainViewController.swift
//  IMDbMovies
//
//  Created by Айтолкун Анарбекова on 8/11/22.
//

import UIKit

class MainViewController: UICollectionViewController {
    
    private var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMovies()

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }

    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 24, height: 220)
    }
}

extension MainViewController {
    func fetchMovies() {
        
        NetworkManager.shared.fetchMovies(by: "avengers") {
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
