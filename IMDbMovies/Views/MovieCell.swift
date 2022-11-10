//
//  MovieCell.swift
//  IMDbMovies
//
//  Created by Айтолкун Анарбекова on 8/11/22.
//

import UIKit

class MovieCell: UICollectionViewCell {
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieNamelabel: UILabel!
    
    
    func configure(with movie: Movie) {
        self.movieNamelabel.text = movie.title
        NetworkManager.shared.fetchMovieImage(from: movie.poster){ [weak self] result in
            switch result {
            case .success(let imageData):
                self?.movieImage.image = UIImage(data: imageData)
            case .failure(_):
                self?.movieImage.image = UIImage(named: "moviePoster")
            }
        }
        
    }
}
