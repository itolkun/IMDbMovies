//
//  UserAddedMovies.swift
//  IMDbMovies
//
//  Created by Айтолкун Анарбекова on 9/11/22.
//

import UIKit

class MovieInfo: UICollectionViewCell {
    
    @IBOutlet var imageMovie: UIImageView! 
    
    func configure(with movie: Movie) {
        NetworkManager.shared.fetchMovieImage(from: movie.poster){ [weak self] result in
            switch result {
            case .success(let imageData):
                self?.imageMovie.image = UIImage(data: imageData)
            case .failure(_):
                self?.imageMovie.image = UIImage(named: "moviePoster")
            }
        }
        
    }
}

